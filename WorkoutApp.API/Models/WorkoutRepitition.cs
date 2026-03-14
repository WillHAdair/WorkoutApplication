namespace WorkoutApp.API.Models;

public enum RepititionMode
{
    SuperSet,
    DropSet
}

public abstract class WorkoutRepitition : NamedEntity 
{
    public TimeSpan? RestPeriod { get; set; } = null; // Optional rest period after completing the set
}

public class TimedRepitition : WorkoutRepitition
{
    public required TimeSpan Duration { get; set; }
    public decimal? Weight { get; set; } = null; // If there is a weighted component to the repitition
}

public class RepetitionCount : WorkoutRepitition
{
    public int? Count { get; set; } = null; // Null indicates to failure, otherwise the number of repititions to complete
    public decimal? Weight { get; set; } = null; // If there is a weighted component to the repitition
}

public class SuperSetRepition : WorkoutRepitition
{
    public IEnumerable<WorkoutRepitition> Exercises { get; set; } = [];
    public required RepititionMode Mode { get; set; } // To distinguish between supersets (different workouts performed back to back) and drop sets (same workout performed with decreasing weight until failure)
}
