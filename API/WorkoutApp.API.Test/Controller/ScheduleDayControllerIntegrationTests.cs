using System.Net;
using System.Net.Http.Json;
using WorkoutApp.API.Models;
using WorkoutApp.API.Test.TestData;
using WorkoutApp.API.Test.TestInfrastructure;

namespace WorkoutApp.API.Test.Controller;

public class ScheduleDayControllerIntegrationTests : IClassFixture<SqlServerContainerFixture>, IAsyncLifetime, IDisposable
{
    private readonly SqlServerContainerFixture _fixture;
    private readonly TestApiWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public ScheduleDayControllerIntegrationTests(SqlServerContainerFixture fixture)
    {
        _fixture = fixture;
        _factory = new TestApiWebApplicationFactory(_fixture.ConnectionString);
        _client = _factory.CreateClient();
    }

    public Task InitializeAsync() => _fixture.ResetDatabaseAsync();

    public Task DisposeAsync() => Task.CompletedTask;

    public void Dispose()
    {
        _client.Dispose();
        _factory.Dispose();
    }

    [Fact]
    public async Task CreateReadUpdateDeleteFlow_ShouldReturnExpectedScheduleDayData()
    {
        await using var db = _fixture.CreateDbContext();
        var user = DomainTestData.CreateUser();
        await db.Users.AddAsync(user);
        await db.SaveChangesAsync();

        var schedule = DomainTestData.CreateSchedule(user.Id, forCreate: false);
        await db.WorkoutSchedules.AddAsync(schedule);
        await db.SaveChangesAsync();

        var dayPayload = DomainTestData.CreateScheduleDay(schedule.Id, forCreate: true);
        var createResponse = await _client.PostAsJsonAsync("/api/ScheduleDay", dayPayload);
        Assert.Equal(HttpStatusCode.OK, createResponse.StatusCode);

        var createResult = await createResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<ScheduleDay>>();
        Assert.NotNull(createResult);
        Assert.True(createResult!.Success);

        var dayId = createResult.Data.Id;

        var getByIdResponse = await _client.GetAsync($"/api/ScheduleDay/{dayId}");
        var getByIdResult = await getByIdResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<ScheduleDay>>();
        Assert.NotNull(getByIdResult);
        Assert.True(getByIdResult!.Success);
        Assert.Equal(dayId, getByIdResult.Data.Id);

        var dateQuery = schedule.StartDate.ToString("yyyy-MM-dd");
        var getByDateResponse = await _client.GetAsync($"/api/ScheduleDay/schedule/{schedule.Id}/date/{dateQuery}");
        var getByDateResult = await getByDateResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<ScheduleDay>>();
        Assert.NotNull(getByDateResult);
        Assert.True(getByDateResult!.Success);
        Assert.Equal(dayId, getByDateResult.Data.Id);

        var updatePayload = new ScheduleDay
        {
            Id = dayId,
            WorkoutScheduleId = schedule.Id,
            Name = "Controller Updated Day",
            Description = "Controller updated day description",
            Exercises = new List<Exercise>()
        };

        var updateResponse = await _client.PutAsJsonAsync($"/api/ScheduleDay/{dayId}", updatePayload);
        var updateResult = await updateResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<ScheduleDay>>();
        Assert.NotNull(updateResult);
        Assert.True(updateResult!.Success);
        Assert.Equal("Controller Updated Day", updateResult.Data.Name);

        var deleteResponse = await _client.DeleteAsync($"/api/ScheduleDay/{dayId}");
        var deleteResult = await deleteResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<bool>>();
        Assert.NotNull(deleteResult);
        Assert.True(deleteResult!.Success);

        var getAfterDeleteResponse = await _client.GetAsync($"/api/ScheduleDay/{dayId}");
        var getAfterDeleteResult = await getAfterDeleteResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<ScheduleDay>>();
        Assert.NotNull(getAfterDeleteResult);
        Assert.False(getAfterDeleteResult!.Success);
        Assert.Equal(404, getAfterDeleteResult.StatusCode);
    }
}
