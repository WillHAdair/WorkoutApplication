using System.ComponentModel.DataAnnotations;

namespace WorkoutApp.API.Models;

public class ScheduleDay : NamedEntity
{
    [Required]
    public required Guid WorkoutScheduleId { get; set; }
    public WorkoutSchedule? WorkoutSchedule { get; set; }

    // Empty collection is assumed to mean rest day
    public ICollection<Exercise> Exercises { get; set; } = new List<Exercise>();
}

