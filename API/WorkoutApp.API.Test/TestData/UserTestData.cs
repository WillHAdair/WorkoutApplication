using WorkoutApp.API.Models;

namespace WorkoutApp.API.Test.TestData;

public static class UserTestData
{
    public static User CreateUser(string? email = null)
    {
        var unique = Guid.NewGuid().ToString("N")[..8];

        return new User
        {
            Id = Guid.NewGuid(),
            Name = $"Test User {unique}",
            Description = "Integration test user",
            Username = $"user_{unique}",
            Email = email ?? $"user_{unique}@example.com",
            PasswordHash = "hashed-password",
            BaseUnit = MeasurementUnit.Metric
        };
    }
}
