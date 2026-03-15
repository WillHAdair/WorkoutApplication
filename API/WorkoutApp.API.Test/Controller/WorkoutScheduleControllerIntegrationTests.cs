using System.Net;
using System.Net.Http.Json;
using WorkoutApp.API.Models;
using WorkoutApp.API.Test.TestData;
using WorkoutApp.API.Test.TestInfrastructure;

namespace WorkoutApp.API.Test.Controller;

public class WorkoutScheduleControllerIntegrationTests : IClassFixture<SqlServerContainerFixture>, IAsyncLifetime, IDisposable
{
    private readonly SqlServerContainerFixture _fixture;
    private readonly TestApiWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public WorkoutScheduleControllerIntegrationTests(SqlServerContainerFixture fixture)
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
    public async Task CreateReadUpdateDeleteFlow_ShouldReturnExpectedScheduleData()
    {
        await using var db = _fixture.CreateDbContext();
        var user = DomainTestData.CreateUser();
        await db.Users.AddAsync(user);
        await db.SaveChangesAsync();

        var schedulePayload = DomainTestData.CreateSchedule(user.Id, forCreate: true);

        var createResponse = await _client.PostAsJsonAsync("/api/WorkoutSchedule", schedulePayload);
        Assert.Equal(HttpStatusCode.OK, createResponse.StatusCode);

        var createResult = await createResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<WorkoutSchedule>>();
        Assert.NotNull(createResult);
        Assert.True(createResult!.Success);
        Assert.Equal(201, createResult.StatusCode);

        var scheduleId = createResult.Data.Id;

        var getByIdResponse = await _client.GetAsync($"/api/WorkoutSchedule/{scheduleId}");
        Assert.Equal(HttpStatusCode.OK, getByIdResponse.StatusCode);

        var getByIdResult = await getByIdResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<WorkoutSchedule>>();
        Assert.NotNull(getByIdResult);
        Assert.True(getByIdResult!.Success);
        Assert.Equal(scheduleId, getByIdResult.Data.Id);

        var getActiveResponse = await _client.GetAsync($"/api/WorkoutSchedule/user/{user.Id}/active");
        Assert.Equal(HttpStatusCode.OK, getActiveResponse.StatusCode);

        var getActiveResult = await getActiveResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<List<WorkoutSchedule>>>();
        Assert.NotNull(getActiveResult);
        Assert.True(getActiveResult!.Success);
        Assert.Single(getActiveResult.Data);

        var updatePayload = new WorkoutSchedule
        {
            Id = scheduleId,
            UserId = user.Id,
            Name = "Controller Updated Schedule",
            Description = "Controller updated description",
            StartDate = createResult.Data.StartDate,
            EndDate = createResult.Data.EndDate,
            ScheduleDays = new List<ScheduleDay>()
        };

        var updateResponse = await _client.PutAsJsonAsync($"/api/WorkoutSchedule/{scheduleId}", updatePayload);
        Assert.Equal(HttpStatusCode.OK, updateResponse.StatusCode);

        var updateResult = await updateResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<WorkoutSchedule>>();
        Assert.NotNull(updateResult);
        Assert.True(updateResult!.Success);
        Assert.Equal("Controller Updated Schedule", updateResult.Data.Name);

        var deleteResponse = await _client.DeleteAsync($"/api/WorkoutSchedule/{scheduleId}");
        Assert.Equal(HttpStatusCode.OK, deleteResponse.StatusCode);

        var deleteResult = await deleteResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<bool>>();
        Assert.NotNull(deleteResult);
        Assert.True(deleteResult!.Success);

        var getAfterDeleteResponse = await _client.GetAsync($"/api/WorkoutSchedule/{scheduleId}");
        var getAfterDeleteResult = await getAfterDeleteResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<WorkoutSchedule>>();
        Assert.NotNull(getAfterDeleteResult);
        Assert.False(getAfterDeleteResult!.Success);
        Assert.Equal(404, getAfterDeleteResult.StatusCode);
    }
}
