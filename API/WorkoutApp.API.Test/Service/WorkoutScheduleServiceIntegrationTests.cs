using Microsoft.EntityFrameworkCore;
using WorkoutApp.API.Models.Results;
using WorkoutApp.API.Services;
using WorkoutApp.API.Test.TestData;
using WorkoutApp.API.Test.TestInfrastructure;

namespace WorkoutApp.API.Test.Service;

public class WorkoutScheduleServiceIntegrationTests(SqlServerContainerFixture fixture)
    : IClassFixture<SqlServerContainerFixture>, IAsyncLifetime
{
    private readonly SqlServerContainerFixture _fixture = fixture;

    public Task InitializeAsync() => _fixture.ResetDatabaseAsync();

    public Task DisposeAsync() => Task.CompletedTask;

    [Fact]
    public async Task CreateUpdateDeleteFlow_ShouldPersistExpectedScheduleData()
    {
        await using var db = _fixture.CreateDbContext();
        var service = new WorkoutScheduleService(db);

        var user = DomainTestData.CreateUser();
        await db.Users.AddAsync(user);
        await db.SaveChangesAsync();

        var schedule = DomainTestData.CreateSchedule(user.Id, forCreate: true);
        var createResult = await service.CreateScheduleAsync(schedule);

        Assert.True(createResult.Success);
        Assert.IsType<CreatedResult<WorkoutApp.API.Models.WorkoutSchedule>>(createResult);
        Assert.NotEqual(Guid.Empty, createResult.Data.Id);

        var created = await db.WorkoutSchedules.AsNoTracking().SingleAsync(s => s.Id == createResult.Data.Id);
        Assert.Equal(user.Id, created.UserId);
        Assert.Equal(schedule.Name, created.Name);
        Assert.Equal(schedule.StartDate, created.StartDate);

        var getActiveResult = await service.GetActiveSchedulesByUserIdAsync(user.Id);
        Assert.True(getActiveResult.Success);
        Assert.Single(getActiveResult.Data);
        Assert.Equal(created.Id, getActiveResult.Data[0].Id);

        var updateRequest = new WorkoutApp.API.Models.WorkoutSchedule
        {
            Id = created.Id,
            UserId = user.Id,
            Name = "Updated Schedule Name",
            Description = "Updated schedule description",
            StartDate = created.StartDate,
            EndDate = created.EndDate,
            ScheduleDays = new List<WorkoutApp.API.Models.ScheduleDay>()
        };

        var updateResult = await service.UpdateScheduleAsync(updateRequest);
        Assert.True(updateResult.Success);

        var updated = await db.WorkoutSchedules.AsNoTracking().SingleAsync(s => s.Id == created.Id);
        Assert.Equal(updateRequest.Name, updated.Name);
        Assert.Equal(updateRequest.Description, updated.Description);

        var deleteResult = await service.DeleteScheduleAsync(created.Id);
        Assert.True(deleteResult.Success);

        var deleted = await db.WorkoutSchedules.FindAsync(created.Id);
        Assert.Null(deleted);
    }
}
