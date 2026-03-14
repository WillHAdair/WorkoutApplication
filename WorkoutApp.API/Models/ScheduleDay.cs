namespace WorkoutApp.API.Models;

public abstract class ScheduleDay : NamedEntity
{
    public required Guid WorkoutScheduleId { get; set; }
    public WorkoutSchedule? WorkoutSchedule { get; set; }

    // Empty collection is assumed to mean rest day
    public IEnumerable<WorkoutExercise> WorkoutExercises { get; set; } = [];
}

