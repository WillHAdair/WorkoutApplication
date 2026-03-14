namespace WorkoutApp.API.Models;

/// <summary>
/// The default measurement units available for a user (imperial or metric)
/// </summary>
public enum MeasurementUnit
{
    Imperial,
    Metric
}

/// <summary>
/// A registered user within the app
/// </summary>
public class User : BaseEntity
{
    public required string Username { get; set; }
    public required string Email { get; set; }
    public required string PasswordHash { get; set; } // NOTE: this will eventually be abstracted away, just need it for now.
    public required MeasurementUnit BaseUnit { get; set; }
}
