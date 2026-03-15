using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace WorkoutApp.API.Models;

[JsonPolymorphic(TypeDiscriminatorPropertyName = "$type")]
[JsonDerivedType(typeof(TimedExercise), typeDiscriminator: "timed")]
[JsonDerivedType(typeof(SetExercise), typeDiscriminator: "set")]
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
    public ICollection<Rep> Sets { get; set; } = new List<Rep>();

    public TimeSpan? RestPeriod { get; set; } = null; // Optional rest period between sets 
}
