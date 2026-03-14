namespace WorkoutApp.API.Models;

public abstract class WorkoutExercise : NamedEntity
{
    public TimeOnly? StartTime { get; set; } // For scheduling purposes
}

public class TimedWorkout : WorkoutExercise
{
    public required TimeSpan WorkoutTime { get; set; }
    public decimal? Weight { get; set; } = null; // If there is a weighted component to the workout
}

public class WorkoutSetExercise : WorkoutExercise
{
    public IEnumerable<WorkoutRepitition> Sets { get; set; } = [];

    public TimeSpan? RestPeriod { get; set; } = null; // Optional rest period between sets 
}
