using Microsoft.EntityFrameworkCore;
using WorkoutApp.API.Database;
using WorkoutApp.API.Models;
using WorkoutApp.API.Models.Results;

namespace WorkoutApp.API.Services;

public interface IRepService
{
    Task<ServiceResult<Rep>> GetWorkoutRepititionByIdAsync(Guid id, CancellationToken token = default);
    Task<ServiceResult<List<Rep>>> GetWorkoutRepititionsByExerciseIdAsync(Guid workoutExerciseId, CancellationToken token = default);
    Task<ServiceResult<Rep>> CreateWorkoutRepititionAsync(Rep workoutRepitition, CancellationToken token = default);
    Task<ServiceResult<Rep>> UpdateWorkoutRepititionAsync(Rep workoutRepitition, CancellationToken token = default);
    Task<ServiceResult<bool>> DeleteWorkoutRepititionAsync(Guid id, CancellationToken token = default);
}

public class RepService(WorkoutAppDbContext context) : IRepService
{
    private readonly string InternalServerErrorMessage = "An error occurred while processing your request.";
    public async Task<ServiceResult<Rep>> GetWorkoutRepititionByIdAsync(Guid id, CancellationToken token = default)
    {
        try
        {
            var workoutRepitition = await context.Reps.FindAsync([id], token);
            if (workoutRepitition == null)
                return new NotFoundResult<Rep>($"WorkoutRepitition with ID {id} not found.");
            return new SuccessResult<Rep>(workoutRepitition);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<Rep>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<List<Rep>>> GetWorkoutRepititionsByExerciseIdAsync(Guid workoutExerciseId, CancellationToken token = default)
    {
        try
        {
            // Make sure to check if any workout repititions exist for the given workoutExerciseId before returning the list
            var query = context.Reps
                .AsNoTracking()
                .Where(wr => wr.ExerciseId == workoutExerciseId);
            if (!query.Any())
                return new NotFoundResult<List<Rep>>("No Workouts found for this workoutExerciseId.");

            var workoutRepititions = await query
                .OrderByDescending(wr => wr.CreatedAt)
                .Include(wr => wr.Exercise)
                .ToListAsync(token);

            return new SuccessResult<List<Rep>>(workoutRepititions);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<List<Rep>>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<Rep>> CreateWorkoutRepititionAsync(Rep workoutRepitition, CancellationToken token = default)
    {
        try
        {
            // Double check the schedule exists before trying to create a day for it
            if (workoutRepitition.ExerciseId == Guid.Empty)
                return new NotFoundResult<Rep>("Workout Exercise ID is required to create a WorkoutRepitition.");
            var workoutExercise = await context.Exercises.FindAsync([workoutRepitition.ExerciseId], token);
            if (workoutExercise == null)
                return new NotFoundResult<Rep>($"Workout Exercise with ID {workoutRepitition.ExerciseId} not found.");

            // Make sure the workoutRepitition does not already exist before trying to create it
            if (workoutRepitition.Id != Guid.Empty)
                return new BadRequestResult<Rep>("New woirkout can not have a predefined ID.");

            var validationResult = IsWorkoutRepititionValid(workoutRepitition);
            if (!validationResult.Success)
                return validationResult;

            workoutRepitition.CreatedAt = DateTime.UtcNow;
            workoutRepitition.UpdatedAt = DateTime.UtcNow;

            await context.Reps.AddAsync(workoutRepitition, token);
            await context.SaveChangesAsync();
            return new CreatedResult<Rep>(workoutRepitition);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<Rep>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<Rep>> UpdateWorkoutRepititionAsync(Rep rep, CancellationToken token = default)     {
        try
        {
            if (rep.Id == Guid.Empty)
                return new BadRequestResult<Rep>("WorkoutRepitition ID is required to update a WorkoutRepitition.");
            var existingRep = await context.Reps.FindAsync([rep.Id], token);
            if (existingRep == null)
                return new NotFoundResult<Rep>($"WorkoutRepitition with ID {rep.Id} not found.");

            // Make sure the workout exercise exists before trying to update the repitition
            var existingExercise = await context.Exercises.FindAsync([existingRep.ExerciseId], token);
            if (existingExercise == null)
                return new NotFoundResult<Rep>($"Workout Exercise with ID {existingRep.ExerciseId} not found.");

            // Updating the type of a rep is not allowed, so make sure the type of the existing rep and the updated rep are the same before trying to update it
            if (existingRep.GetType() != rep.GetType())
                return new BadRequestResult<Rep>("Updating the type of a rep is not allowed.");

            // Double check the updated rep is valid before trying to update it
            var validationResult = IsWorkoutRepititionValid(rep);
            if (!validationResult.Success)
                return validationResult;

            existingRep.Name = rep.Name;
            existingRep.Description = rep.Description;
            existingRep.RestPeriod = rep.RestPeriod;
            if (existingRep is TimedRep existingTimed && rep is TimedRep updatedTimed)
            {
                existingTimed.Duration = updatedTimed.Duration;
                existingTimed.Weight = updatedTimed.Weight;
            }
            else if (existingRep is CountedRep existingCounted && rep is CountedRep updatedCounted)
            {
                existingCounted.Count = updatedCounted.Count;
                existingCounted.Weight = updatedCounted.Weight;
            }
            else if (existingRep is SuperSetRep existingSuperSet && rep is SuperSetRep updatedSuperSet)
            {
                existingSuperSet.Mode = updatedSuperSet.Mode;
                existingSuperSet.Exercises = updatedSuperSet.Exercises;
            }
            else
                return new BadRequestResult<Rep>("The provided rep type is not supported.");
            existingRep.UpdatedAt = DateTime.UtcNow;

            context.Reps.Update(existingRep);
            await context.SaveChangesAsync(token);
            return new SuccessResult<Rep>(existingRep);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<Rep>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<bool>> DeleteWorkoutRepititionAsync(Guid id, CancellationToken token = default)
    {
        try
        {
            var existingRep = await context.Reps.FindAsync([id], token);
            if (existingRep == null)
                return new NotFoundResult<bool>($"WorkoutRepitition with ID {id} not found.");

            context.Reps.Remove(existingRep);
            await context.SaveChangesAsync(token);
            return new SuccessResult<bool>(true);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<bool>(InternalServerErrorMessage);
        }
    }

    private static ServiceResult<Rep> IsWorkoutRepititionValid(Rep rep)
    {
        if (rep.RestPeriod.HasValue && rep.RestPeriod.Value < TimeSpan.Zero)
            return new BadRequestResult<Rep>("Rest period must be a positive value.");
        if (rep.RestPeriod.HasValue && rep.RestPeriod.Value.Hours >= TimeSpan.HoursPerDay)
            return new BadRequestResult<Rep>("Rest period must be less than 24 hours.");

        if (rep is TimedRep timed)
        {
            if (timed.Duration <= TimeSpan.Zero)
                return new BadRequestResult<Rep>("Duration must be a positive value.");
            else if (timed.Duration.Hours > TimeSpan.HoursPerDay)
                return new BadRequestResult<Rep>("Duration must be less than 24 hours.");
        }
        else if (rep is CountedRep counted)
        {
            if (counted.Count.HasValue && counted.Count.Value <= 0)
                return new BadRequestResult<Rep>("Count must be a positive integer.");
        }
        else if (rep is SuperSetRep superSet)
        {
            // Double check no infinite loops are possible with super sets
            if (superSet.Exercises.Any(e => e is SuperSetRep))
                return new BadRequestResult<Rep>("Super sets cannot contain other super sets.");
            foreach (Rep exercise in superSet.Exercises)
            {
                var validationResult = IsWorkoutRepititionValid(exercise);
                if (validationResult is not SuccessResult<Rep>)
                    return validationResult;
            }
        }
        else
            return new BadRequestResult<Rep>("The provided rep type is not supported.");
        return new NoContentResult<Rep>();
    }
}
