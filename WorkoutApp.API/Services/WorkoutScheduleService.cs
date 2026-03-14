using Microsoft.EntityFrameworkCore;
using WorkoutApp.API.Database;
using WorkoutApp.API.Models;
using WorkoutApp.API.Models.Results;

namespace WorkoutApp.API.Services;

public interface IWorkoutScheduleService
{
    Task<ServiceResult<WorkoutSchedule>> GetScheduleByIdAsync(Guid id);
    Task<ServiceResult<List<WorkoutSchedule>>> GetActiveSchedulesByUserIdAsync(Guid userId);
    Task<ServiceResult<List<WorkoutSchedule>>> GetSchedulesByUserIdAsync(Guid userId);
    Task<ServiceResult<WorkoutSchedule>> CreateScheduleAsync(WorkoutSchedule schedule);
    Task<ServiceResult<WorkoutSchedule>> UpdateScheduleAsync(WorkoutSchedule schedule);
    Task<ServiceResult<bool>> DeleteScheduleAsync(Guid id);
}

public class WorkoutScheduleService(WorkoutAppDbContext context) : IWorkoutScheduleService
{
    private readonly string InternalServerErrorMessage = "An error occurred while processing your request.";
    public async Task<ServiceResult<WorkoutSchedule>> GetScheduleByIdAsync(Guid id)
    {
        try
        {
            var schedule = await context.WorkoutSchedules.FindAsync(id);
            if (schedule == null)
                return new NotFoundResult<WorkoutSchedule>("Workout schedule not found.");
            return new SuccessResult<WorkoutSchedule>(schedule);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<WorkoutSchedule>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<List<WorkoutSchedule>>> GetActiveSchedulesByUserIdAsync(Guid userId)
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
                    .ThenInclude(sd => sd.WorkoutExercises)
                .ToListAsync();
            return new SuccessResult<List<WorkoutSchedule>>(schedules);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<List<WorkoutSchedule>>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<List<WorkoutSchedule>>> GetSchedulesByUserIdAsync(Guid userId)
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
                    .ThenInclude(sd => sd.WorkoutExercises)
                .ToListAsync();
            return new SuccessResult<List<WorkoutSchedule>>(schedules);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<List<WorkoutSchedule>>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<WorkoutSchedule>> CreateScheduleAsync(WorkoutSchedule schedule)
    {
        try
        {
            await context.WorkoutSchedules.AddAsync(schedule);
            await context.SaveChangesAsync();
            return new CreatedResult<WorkoutSchedule>(schedule);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<WorkoutSchedule>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<WorkoutSchedule>> UpdateScheduleAsync(WorkoutSchedule schedule)
    {
        try
        {
            var existing