using Microsoft.EntityFrameworkCore;
using WorkoutApp.API.Database;
using WorkoutApp.API.Models;
using WorkoutApp.API.Models.Results;

namespace WorkoutApp.API.Services;

public interface IWorkoutScheduleService
{
    Task<ServiceResult<WorkoutSchedule>> GetScheduleByIdAsync(Guid id, CancellationToken token = default);
    Task<ServiceResult<List<WorkoutSchedule>>> GetActiveSchedulesByUserIdAsync(Guid userId, CancellationToken token = default);
    Task<ServiceResult<List<WorkoutSchedule>>> GetSchedulesByUserIdAsync(Guid userId, CancellationToken token = default);
    Task<ServiceResult<WorkoutSchedule>> CreateScheduleAsync(WorkoutSchedule schedule, CancellationToken token = default);
    Task<ServiceResult<WorkoutSchedule>> UpdateScheduleAsync(WorkoutSchedule schedule, CancellationToken token = default);
    Task<ServiceResult<bool>> DeleteScheduleAsync(Guid id, CancellationToken token = default);
}

public class WorkoutScheduleService(WorkoutAppDbContext context) : IWorkoutScheduleService
{
    private readonly string InternalServerErrorMessage = "An error occurred while processing your request.";
    public async Task<ServiceResult<WorkoutSchedule>> GetScheduleByIdAsync(Guid id, CancellationToken token = default)
    {
        try
        {
            var schedule = await context.WorkoutSchedules.FindAsync([id], token);
            if (schedule == null)
                return new NotFoundResult<WorkoutSchedule>("Workout schedule not found.");
            return new SuccessResult<WorkoutSchedule>(schedule);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<WorkoutSchedule>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<List<WorkoutSchedule>>> GetActiveSchedulesByUserIdAsync(Guid userId, CancellationToken token = default)
    {
        try
        {
            var today = DateOnly.FromDateTime(DateTime.UtcNow);
            var query = context.WorkoutSchedules
                .AsNoTracking()
                .Where(s => s.UserId == userId && s.StartDate <= today && (s.EndDate == null || s.EndDate >= today));

            if (!query.Any())
                return new NotFoundResult<List<WorkoutSchedule>>("No active workout schedule found for this user.");

            var schedules = await query
                .OrderByDescending(s => s.StartDate)
                .Include(s => s.ScheduleDays)
                    .ThenInclude(sd => sd.Exercises)
                .ToListAsync(token);
            return new SuccessResult<List<WorkoutSchedule>>(schedules);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<List<WorkoutSchedule>>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<List<WorkoutSchedule>>> GetSchedulesByUserIdAsync(Guid userId, CancellationToken token = default)
    {
        try
        {
            var query = context.WorkoutSchedules
                .AsNoTracking()
                .Where(s => s.UserId == userId);
            if (!query.Any())
                return new NotFoundResult<List<WorkoutSchedule>>("No workout schedules found for this user.");

            var schedules = await query
                .OrderByDescending(s => s.StartDate)
                .Include(s => s.ScheduleDays)
                    .ThenInclude(sd => sd.Exercises)
                .ToListAsync(token);
            return new SuccessResult<List<WorkoutSchedule>>(schedules);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<List<WorkoutSchedule>>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<WorkoutSchedule>> CreateScheduleAsync(WorkoutSchedule schedule, CancellationToken token = default)
    {
        try
        {
            if (schedule.Id != Guid.Empty)
                return new BadRequestResult<WorkoutSchedule>("Schedule ID may not be populated when creating a new schedule");

            // Double check user exists
            var user = await context.Users.FindAsync([schedule.UserId], token);
            if (user == null)
                return new BadRequestResult<WorkoutSchedule>("User not found for the provided UserId.");

            // Make sure that the start date does not conflict with the end date
            if (schedule.EndDate.HasValue && schedule.EndDate < schedule.StartDate)
                return new BadRequestResult<WorkoutSchedule>("End date cannot be before start date.");

            // Clear out any schedule days (these cannot be created on initial entry)
            if (schedule.ScheduleDays != null && schedule.ScheduleDays.Any())
                return new BadRequestResult<WorkoutSchedule>("Schedule days cannot be included when creating a new schedule. Please create the schedule first, then add schedule days.");

            schedule.CreatedAt = DateTime.UtcNow;
            schedule.UpdatedAt = DateTime.UtcNow;

            await context.WorkoutSchedules.AddAsync(schedule, token);
            await context.SaveChangesAsync(token);
            return new CreatedResult<WorkoutSchedule>(schedule);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<WorkoutSchedule>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<WorkoutSchedule>> UpdateScheduleAsync(WorkoutSchedule schedule, CancellationToken token = default)
    {
        try
        {
            // Check that the schedule exists
            var existingSchedule = await context.WorkoutSchedules.FindAsync([schedule.Id], token);
            if (existingSchedule == null)
                return new NotFoundResult<WorkoutSchedule>("Workout schedule not found.");

            // Make sure that the user ID is not being changed
            if (existingSchedule.UserId != schedule.UserId)
                return new BadRequestResult<WorkoutSchedule>("User ID cannot be changed for an existing workout schedule.");

            // Make sure that the start date does not conflict with the end date
            if (schedule.EndDate.HasValue && schedule.EndDate < schedule.StartDate)
                return new BadRequestResult<WorkoutSchedule>("End date cannot be before start date.");

            // Apply changes to the existing schedule record
            existingSchedule.Name = schedule.Name;
            existingSchedule.Description = schedule.Description;
            existingSchedule.UpdatedAt = DateTime.UtcNow;
            existingSchedule.StartDate = schedule.StartDate;
            existingSchedule.EndDate = schedule.EndDate;

            context.WorkoutSchedules.Update(existingSchedule);
            await context.SaveChangesAsync(token);
            return new SuccessResult<WorkoutSchedule>(existingSchedule);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<WorkoutSchedule>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<bool>> DeleteScheduleAsync(Guid id, CancellationToken token = default)
    {
        try
        {
            var schedule = await context.WorkoutSchedules.FindAsync([id], token);
            if (schedule == null)
                return new NotFoundResult<bool>("Workout schedule not found.");
            context.WorkoutSchedules.Remove(schedule);
            await context.SaveChangesAsync(token);
            return new NoContentResult<bool>();
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<bool>(InternalServerErrorMessage);
        }
    }
}