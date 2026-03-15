using WorkoutApp.API.Models;

namespace WorkoutApp.API.Test.TestData;

public static class DomainTestData
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

    public static WorkoutSchedule CreateSchedule(Guid userId, bool forCreate = true)
    {
        var unique = Guid.NewGuid().ToString("N")[..8];
        return new WorkoutSchedule
        {
            Id = forCreate ? Guid.Empty : Guid.NewGuid(),
            UserId = userId,
            Name = $"Schedule {unique}",
            Description = "Integration test schedule",
            StartDate = DateOnly.FromDateTime(DateTime.UtcNow.Date),
            EndDate = DateOnly.FromDateTime(DateTime.UtcNow.Date.AddDays(30)),
            ScheduleDays = new List<ScheduleDay>()
        };
    }

    public static ScheduleDay CreateScheduleDay(Guid scheduleId, bool forCreate = true)
    {
        var unique = Guid.NewGuid().ToString("N")[..8];
        return new ScheduleDay
        {
            Id = forCreate ? Guid.Empty : Guid.NewGuid(),
            WorkoutScheduleId = scheduleId,
            Name = $"Day {unique}",
            Description = "Integration test schedule day",
            Exercises = new List<Exercise>()
        };
    }

    public static TimedExercise CreateTimedExercise(Guid scheduleDayId, bool forCreate = true)
    {
        var unique = Guid.NewGuid().ToString("N")[..8];
        return new TimedExercise
        {
            Id = forCreate ? Guid.Empty : Guid.NewGuid(),
            ScheduleDayId = scheduleDayId,
            Name = $"Timed Exercise {unique}",
            Description = "Integration test timed exercise",
            WorkoutTime = TimeSpan.FromMinutes(30),
            StartTime = new TimeOnly(6, 0),
            Weight = 12.5m
        };
    }

    public static SetExercise CreateSetExercise(Guid scheduleDayId, bool forCreate = true)
    {
        var unique = Guid.NewGuid().ToString("N")[..8];
        return new SetExercise
        {
            Id = forCreate ? Guid.Empty : Guid.NewGuid(),
            ScheduleDayId = scheduleDayId,
            Name = $"Set Exercise {unique}",
            Description = "Integration test set exercise",
            RestPeriod = TimeSpan.FromSeconds(90),
            StartTime = new TimeOnly(7, 0),
            Sets = new List<Rep>()
        };
    }

    public static CountedRep CreateCountedRep(Guid exerciseId, bool forCreate = true)
    {
        var unique = Guid.NewGuid().ToString("N")[..8];
        return new CountedRep
        {
            Id = forCreate ? Guid.Empty : Guid.NewGuid(),
            ExerciseId = exerciseId,
            Name = $"Rep {unique}",
            Description = "Integration test counted rep",
            Count = 12,
            Weight = 45.0m,
            RestPeriod = TimeSpan.FromSeconds(60)
        };
    }

    public static TimedRep CreateTimedRep(Guid exerciseId, bool forCreate = true)
    {
        var unique = Guid.NewGuid().ToString("N")[..8];
        return new TimedRep
        {
            Id = forCreate ? Guid.Empty : Guid.NewGuid(),
            ExerciseId = exerciseId,
            Name = $"Timed Rep {unique}",
            Description = "Integration test timed rep",
            Duration = TimeSpan.FromSeconds(45),
            Weight = 15.0m,
            RestPeriod = TimeSpan.FromSeconds(30)
        };
    }
}
