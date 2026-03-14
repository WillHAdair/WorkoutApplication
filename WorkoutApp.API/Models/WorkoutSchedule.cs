namespace WorkoutApp.API.Models;

public class WorkoutSchedule : NamedEntity
{
    public required Guid UserId { get; set; }
    public User? User { get; set; }

    public DateOnly StartDate { get; set; }
    public DateOnly? EndDate { get; set; } = null;

    public IEnumerable<ScheduleDay> ScheduleDays { get; set; } = [];
}
