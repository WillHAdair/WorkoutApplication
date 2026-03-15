using Microsoft.EntityFrameworkCore;
using WorkoutApp.API.Services;
using WorkoutApp.API.Test.TestData;
using WorkoutApp.API.Test.TestInfrastructure;

namespace WorkoutApp.API.Test.Service;

public class ScheduleDayServiceIntegrationTests(SqlServerContainerFixture fixture)
    : IClassFixture<SqlServerContainerFixture>, IAsyncLifetime
{
    private readonly SqlServerContainerFixture _fixture = fixture;

    public Task InitializeAsync() => _fixture.ResetDatabaseAsync();

    public Task DisposeAsync() => Task.CompletedTask;

    [Fact]
    public async Task CreateGetForDateUpdateDeleteFlow_ShouldReturnExpectedDayAndPersistChanges()
    {
        await using var db = _fixture.CreateDbContext();
        var dayService = new ScheduleDayService(db);

        var user = DomainTestData.CreateUser();
        await db.Users.AddAsync(user);
        await db.SaveChangesAsync();

        var schedule = DomainTestData.CreateSchedule(user.Id, forCreate: false);
        await db.WorkoutSchedules.AddAsync(schedule);
        await db.SaveChangesAsync();

        var dayA = DomainTestData.CreateScheduleDay(schedule.Id, forCreate: true);
        dayA.Name = "Leg Day";
        var dayB = DomainTestData.CreateScheduleDay(schedule.Id, forCreate: true);
        dayB.Name = "Push Day";

        var createDayA = await dayService.CreateScheduleDayAsync(dayA);
        var createDayB = await dayService.CreateScheduleDayAsync(dayB);
        Assert.True(createDayA.Success);
        Assert.True(createDayB.Success);

        var secondDate = schedule.StartDate.AddDays(1);
        var getByDate = await dayService.GetScheduleDayForDayAsync(schedule.Id, secondDate);
        Assert.True(getByDate.Success);
        Assert.Equal("Push Day", getByDate.Data.Name);

        var updateRequest = new WorkoutApp.API.Models.ScheduleDay
        {
            Id = createDayA.Data.Id,
            WorkoutScheduleId = schedule.Id,
            Name = "Leg Day Updated",
            Description = "Updated description",
            Exercises = new List<WorkoutApp.API.Models.Exercise>()
        };

        var updateResult = await dayService.UpdateScheduleDayAsync(updateRequest);
        Assert.True(updateResult.Success);

        var updated = await db.ScheduleDays.AsNoTracking().SingleAsync(d => d.Id == createDayA.Data.Id);
        Assert.Equal("Leg Day Updated", updated.Name);
        Assert.Equal("Updated description", updated.Description);

        var deleteResult = await dayService.DeleteScheduleDayAsync(createDayB.Data.Id);
        Assert.True(deleteResult.Success);

        var deleted = await db.ScheduleDays.FindAsync(createDayB.Data.Id);
        Assert.Null(deleted);
    }
}
