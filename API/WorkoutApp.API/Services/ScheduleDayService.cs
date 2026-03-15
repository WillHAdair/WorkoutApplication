using Microsoft.EntityFrameworkCore;
using WorkoutApp.API.Database;
using WorkoutApp.API.Models;
using WorkoutApp.API.Models.Results;

namespace WorkoutApp.API.Services;

public interface IScheduleDayService
{
    Task<ServiceResult<ScheduleDay>> GetScheduleDayByIdAsync(Guid id, CancellationToken token = default);
    Task<ServiceResult<List<ScheduleDay>>> GetScheduleDaysByScheduleIdAsync(Guid scheduleId, CancellationToken token = default);
    Task<ServiceResult<ScheduleDay>> GetScheduleDayForDayAsync(Guid scheduleId, DateOnly date, CancellationToken token = default);
    Task<ServiceResult<ScheduleDay>> CreateScheduleDayAsync(ScheduleDay scheduleDay, CancellationToken token = default);
    Task<ServiceResult<ScheduleDay>> UpdateScheduleDayAsync(ScheduleDay scheduleDay, CancellationToken token = default);
    Task<ServiceResult<bool>> DeleteScheduleDayAsync(Guid id, CancellationToken token = default);
}

public class ScheduleDayService(WorkoutAppDbContext context) : IScheduleDayService
{
    private readonly string InternalServerErrorMessage = "An error occurred while processing your request.";
    public async Task<ServiceResult<ScheduleDay>> GetScheduleDayByIdAsync(Guid id, CancellationToken token = default)
    {
        try
        {
            var scheduleDay = await context.ScheduleDays.FindAsync([id], cancellationToken: token);
            if (scheduleDay == null)
                return new NotFoundResult<ScheduleDay>("Schedule day not found.");
            return new SuccessResult<ScheduleDay>(scheduleDay);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<ScheduleDay>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<List<ScheduleDay>>> GetScheduleDaysByScheduleIdAsync(Guid scheduleId, CancellationToken token = default)
    {
        try
        {
            var query = context.ScheduleDays
                .AsNoTracking()
                .Where(sd => sd.WorkoutScheduleId == scheduleId);
            if (!query.Any())
                return new NotFoundResult<List<ScheduleDay>>("No schedule days found for this workout schedule.");

            var scheduleDays = await query
                .OrderByDescending(sd => sd.CreatedAt)
                .Include(sd => sd.Exercises)
                .ToListAsync(token);

            return new SuccessResult<List<ScheduleDay>>(scheduleDays);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<List<ScheduleDay>>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<ScheduleDay>> GetScheduleDayForDayAsync(Guid scheduleId, DateOnly date, CancellationToken token = default)
    {
        try
        {
            var schedule = await context.WorkoutSchedules.FindAsync([scheduleId], token);
            if (schedule == null)
                return new NotFoundResult<ScheduleDay>("Workout schedule not found.");
            if (date < schedule.StartDate || (schedule.EndDate.HasValue && date > schedule.EndDate))
                return new NotFoundResult<ScheduleDay>("The specified date is outside the workout schedule's date range.");

            var query = context.ScheduleDays
                .AsNoTracking()
                .Where(sd => sd.WorkoutScheduleId == scheduleId);
            if (!query.Any())
                return new NotFoundResult<ScheduleDay>("No schedule day found for the specified day number.");

            // Calculate the day number based on the schedule's start date
            int dayNumber = (date.DayNumber - schedule.StartDate.DayNumber);
            var scheduleIndex = dayNumber % query.Count();
            var day = await query
                .OrderBy(sd => sd.CreatedAt)
                .Skip(scheduleIndex)
                .FirstOrDefaultAsync(token);

            if (day == null)
                return new NotFoundResult<ScheduleDay>("No schedule day found for the specified date."); // This case should be rare since we already checked for an empty schedule, but it's good to handle it just in case

            return new SuccessResult<ScheduleDay>(day);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<ScheduleDay>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<ScheduleDay>> CreateScheduleDayAsync(ScheduleDay scheduleDay, CancellationToken token = default)
    {
        try
        {
            // Double check the schedule exists before trying to create a day for it
            if (scheduleDay.WorkoutScheduleId == Guid.Empty)
                return new BadRequestResult<ScheduleDay>("Workout schedule ID is required.");
            var schedule = await context.WorkoutSchedules.FindAsync([scheduleDay.WorkoutScheduleId], token);
            if (schedule == null)
                return new NotFoundResult<ScheduleDay>("Workout schedule not found.");

            // Make sure the day does not have an ID set, since we're creating a new one
            if (scheduleDay.Id != Guid.Empty)
                return new BadRequestResult<ScheduleDay>("New schedule day cannot have an ID.");

            // No workouts should be included when creating a new schedule day, since they will be added separately after the day is created
            if (scheduleDay.Exercises != null && scheduleDay.Exercises.Any())
                return new BadRequestResult<ScheduleDay>("New schedule day cannot include workout exercises.");

            scheduleDay.CreatedAt = DateTime.UtcNow;
            scheduleDay.UpdatedAt = DateTime.UtcNow;

            await context.ScheduleDays.AddAsync(scheduleDay, token);
            await context.SaveChangesAsync(token);
            return new SuccessResult<ScheduleDay>(scheduleDay);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<ScheduleDay>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<ScheduleDay>> UpdateScheduleDayAsync(ScheduleDay scheduleDay, CancellationToken token = default)
    {
        try
        {
            // Make sure the schedule day exists before trying to update it
            var existingDay = await context.ScheduleDays.FindAsync([scheduleDay.Id], token);
            if (existingDay == null)
                return new NotFoundResult<ScheduleDay>("Schedule day not found.");

            // The workout schedule ID cannot be changed when updating a schedule day, since that would essentially be moving the day to a different schedule, which is not currently supported
            if (existingDay.WorkoutScheduleId != scheduleDay.WorkoutScheduleId)
                return new BadRequestResult<ScheduleDay>("Workout schedule ID cannot be changed when updating a schedule day.");

            existingDay.Name = scheduleDay.Name;
            existingDay.Description = scheduleDay.Description;
            existingDay.UpdatedAt = DateTime.UtcNow;

            context.ScheduleDays.Update(existingDay);
            await context.SaveChangesAsync(token);
            return new SuccessResult<ScheduleDay>(existingDay);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<ScheduleDay>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<bool>> DeleteScheduleDayAsync(Guid id, CancellationToken token = default)
    {
        try
        {
            var existingDay = await context.ScheduleDays.FindAsync([id], token);
            if (existingDay == null)
                return new NotFoundResult<bool>("Schedule day not found.");

            context.ScheduleDays.Remove(existingDay);
            await context.SaveChangesAsync(token);
            return new SuccessResult<bool>(true);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<bool>(InternalServerErrorMessage);
        }
    }
}
