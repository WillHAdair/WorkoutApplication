using System.ComponentModel.DataAnnotations;

namespace WorkoutApp.API.Models;

public abstract class Exercise : NamedEntity
{
    [Required]
    public required Guid ScheduleDayId { get; set; }
    public ScheduleDay? ScheduleDay { get; set; }

    public TimeOnly? StartTime { get; set; } // For scheduling purposes
}

public class TimedExercise : Exercise
{
    [Required]
    public required TimeSpan WorkoutTime { get; set; }
    public decimal? Weight { get; set; } = null; // If there is a weighted component to the workout
}

public class SetExercise : Exercise
{
    public IEnumerable<Rep> Sets { get; set; } = [];

    public TimeSpan? RestPeriod { get; set; } = null; // Optional rest period between sets 
}
