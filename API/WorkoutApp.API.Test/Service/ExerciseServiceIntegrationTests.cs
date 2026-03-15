using Microsoft.EntityFrameworkCore;
using WorkoutApp.API.Models;
using WorkoutApp.API.Services;
using WorkoutApp.API.Test.TestData;
using WorkoutApp.API.Test.TestInfrastructure;

namespace WorkoutApp.API.Test.Service;

public class ExerciseServiceIntegrationTests(SqlServerContainerFixture fixture)
    : IClassFixture<SqlServerContainerFixture>, IAsyncLifetime
{
    private readonly SqlServerContainerFixture _fixture = fixture;

    public Task InitializeAsync() => _fixture.ResetDatabaseAsync();

    public Task DisposeAsync() => Task.CompletedTask;

    [Fact]
    public async Task CreateListUpdateDeleteFlow_ShouldPersistExpectedExerciseValues()
    {
        await using var db = _fixture.CreateDbContext();
        var exerciseService = new ExerciseService(db);

        var user = DomainTestData.CreateUser();
        await db.Users.AddAsync(user);
        await db.SaveChangesAsync();

        var schedule = DomainTestData.CreateSchedule(user.Id, forCreate: false);
        await db.WorkoutSchedules.AddAsync(schedule);

        var day = DomainTestData.CreateScheduleDay(schedule.Id, forCreate: false);
        await db.ScheduleDays.AddAsync(day);
        await db.SaveChangesAsync();

        var timedExercise = DomainTestData.CreateTimedExercise(day.Id, forCreate: true);
        var createResult = await exerciseService.CreateWorkoutExerciseAsync(timedExercise);

        Assert.True(createResult.Success);
        Assert.NotEqual(Guid.Empty, createResult.Data.Id);

        var listResult = await exerciseService.GetWorkoutExercisesByScheduleDayIdAsync(day.Id);
        Assert.True(listResult.Success);
        Assert.Single(listResult.Data);
        Assert.Equal(createResult.Data.Id, listResult.Data[0].Id);

        var updateRequest = new TimedExercise
        {
            Id = createResult.Data.Id,
            ScheduleDayId = day.Id,
            Name = "Updated Timed Exercise",
            Description = "Updated exercise description",
            WorkoutTime = TimeSpan.FromMinutes(40),
            StartTime = new TimeOnly(8, 30),
            Weight = 20m
        };

        var updateResult = await exerciseService.UpdateWorkoutExerciseAsync(updateRequest);
        Assert.True(updateResult.Success);

        var updated = await db.Exercises.AsNoTracking().SingleAsync(e => e.Id == createResult.Data.Id);
        Assert.Equal("Updated Timed Exercise", updated.Name);
        Assert.IsType<TimedExercise>(updated);

        var typedUpdated = (TimedExercise)updated;
        Assert.Equal(TimeSpan.FromMinutes(40), typedUpdated.WorkoutTime);
        Assert.Equal(20m, typedUpdated.Weight);

        var deleteResult = await exerciseService.DeleteWorkoutExerciseAsync(createResult.Data.Id);
        Assert.True(deleteResult.Success);

        var deleted = await db.Exercises.FindAsync(createResult.Data.Id);
        Assert.Null(deleted);
    }
}
