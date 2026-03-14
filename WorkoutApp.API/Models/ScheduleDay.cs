namespace WorkoutApp.API.Models;

public abstract class ScheduleDay : NamedEntity
{
    public required Guid WorkoutScheduleId { get; set; }
    public WorkoutSchedule? WorkoutSchedule { get; set; }
}

public class RestDay : ScheduleDay
{
}

public class WorkoutDay : ScheduleDay
{
    public IEnumerable<WorkoutExercise> WorkoutExercises { get; set; } = [];
}
