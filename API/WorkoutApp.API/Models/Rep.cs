using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace WorkoutApp.API.Models;

public enum RepititionMode
{
    SuperSet,
    DropSet
}

[JsonPolymorphic(TypeDiscriminatorPropertyName = "$type")]
[JsonDerivedType(typeof(TimedRep), typeDiscriminator: "timed")]
[JsonDerivedType(typeof(CountedRep), typeDiscriminator: "counted")]
[JsonDerivedType(typeof(SuperSetRep), typeDiscriminator: "superset")]
public abstract class Rep : NamedEntity 
{
    [Required]
    public required Guid ExerciseId { get; set; }
    public SetExercise? Exercise { get; set; }

    public TimeSpan? RestPeriod { get; set; } = null; // Optional rest period after completing the set
}

public class TimedRep : Rep
{
    [Required]
    public required TimeSpan Duration { get; set; }
    public decimal? Weight { get; set; } = null; // If there is a weighted component to the repitition
}

public class CountedRep : Rep
{
    [Range(1, int.MaxValue, ErrorMessage = "Count must be a positive integer.")]
    public int? Count { get; set; } = null; // Null indicates to failure, otherwise the number of repititions to complete
    public decimal? Weight { get; set; } = null; // If there is a weighted component to the repitition
}

public class SuperSetRep : Rep
{
    public ICollection<Rep> Exercises { get; set; } = new List<Rep>();
    [Required]
    public required RepititionMode Mode { get; set; } // To distinguish between supersets (different workouts performed back to back) and drop sets (same workout performed with decreasing weight until failure)
}
