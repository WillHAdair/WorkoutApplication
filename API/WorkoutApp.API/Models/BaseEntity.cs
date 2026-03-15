using System.ComponentModel.DataAnnotations;

namespace WorkoutApp.API.Models;

public abstract class BaseEntity
{
    [Required]
    public required Guid Id { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;
}

public abstract class NamedEntity : BaseEntity
{
    [Required(AllowEmptyStrings = false)]
    public required string Name { get; set; }
    public string Description { get; set; } = string.Empty;
}
