using Microsoft.EntityFrameworkCore;
using WorkoutApp.API.Models;
using WorkoutApp.API.Services;
using WorkoutApp.API.Test.TestData;
using WorkoutApp.API.Test.TestInfrastructure;

namespace WorkoutApp.API.Test.Service;

public class RepServiceIntegrationTests(SqlServerContainerFixture fixture)
    : IClassFixture<SqlServerContainerFixture>, IAsyncLifetime
{
    private readonly SqlServerContainerFixture _fixture = fixture;

    public Task InitializeAsync() => _fixture.ResetDatabaseAsync();

    public Task DisposeAsync() => Task.CompletedTask;

    [Fact]
    public async Task CreateListUpdateDeleteFlow_ShouldPersistExpectedRepValues()
    {
        await using var db = _fixture.CreateDbContext();
        var repService = new RepService(db);

        var user = DomainTestData.CreateUser();
        await db.Users.AddAsync(user);
        await db.SaveChangesAsync();

        var schedule = DomainTestData.CreateSchedule(user.Id, forCreate: false);
        await db.WorkoutSchedules.AddAsync(schedule);

        var day = DomainTestData.CreateScheduleDay(schedule.Id, forCreate: false);
        await db.ScheduleDays.AddAsync(day);

        var setExercise = DomainTestData.CreateSetExercise(day.Id, forCreate: false);
        await db.Exercises.AddAsync(setExercise);
        await db.SaveChangesAsync();

        var countedRep = DomainTestData.CreateCountedRep(setExercise.Id, forCreate: true);
        var createResult = await repService.CreateWorkoutRepititionAsync(countedRep);

        Assert.True(createResult.Success);
        Assert.NotEqual(Guid.Empty, createResult.Data.Id);

        var listResult = await repService.GetWorkoutRepititionsByExerciseIdAsync(setExercise.Id);
        Assert.True(listResult.Success);
        Assert.Single(listResult.Data);
        Assert.Equal(createResult.Data.Id, listResult.Data[0].Id);

        var updateRequest = new CountedRep
        {
            Id = createResult.Data.Id,
            ExerciseId = setExercise.Id,
            Name = "Updated Counted Rep",
            Description = "Updated rep description",
            Count = 15,
            Weight = 55.5m,
            RestPeriod = TimeSpan.FromSeconds(75)
        };

        var updateResult = await repService.UpdateWorkoutRepititionAsync(updateRequest);
        Assert.True(updateResult.Success);

        var updated = await db.Reps.AsNoTracking().SingleAsync(r => r.Id == createResult.Data.Id);
        Assert.Equal("Updated Counted Rep", updated.Name);
        Assert.IsType<CountedRep>(updated);

        var typedUpdated = (CountedRep)updated;
        Assert.Equal(15, typedUpdated.Count);
        Assert.Equal(55.5m, typedUpdated.Weight);

        var deleteResult = await repService.DeleteWorkoutRepititionAsync(createResult.Data.Id);
        Assert.True(deleteResult.Success);

        var deleted = await db.Reps.FindAsync(createResult.Data.Id);
        Assert.Null(deleted);
    }
}
