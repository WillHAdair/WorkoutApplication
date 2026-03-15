using System.Net;
using System.Net.Http.Json;
using System.Text.Json;
using WorkoutApp.API.Models;
using WorkoutApp.API.Test.TestData;
using WorkoutApp.API.Test.TestInfrastructure;

namespace WorkoutApp.API.Test.Controller;

public class ExerciseControllerIntegrationTests : IClassFixture<SqlServerContainerFixture>, IAsyncLifetime, IDisposable
{
    private readonly SqlServerContainerFixture _fixture;
    private readonly TestApiWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public ExerciseControllerIntegrationTests(SqlServerContainerFixture fixture)
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
    public async Task CreateReadUpdateDeleteFlow_ShouldHandlePolymorphicExercisePayloads()
    {
        await using var db = _fixture.CreateDbContext();
        var user = DomainTestData.CreateUser();
        await db.Users.AddAsync(user);
        await db.SaveChangesAsync();

        var schedule = DomainTestData.CreateSchedule(user.Id, forCreate: false);
        await db.WorkoutSchedules.AddAsync(schedule);

        var day = DomainTestData.CreateScheduleDay(schedule.Id, forCreate: false);
        await db.ScheduleDays.AddAsync(day);
        await db.SaveChangesAsync();

        var createPayload = new Dictionary<string, object?>
        {
            ["$type"] = "timed",
            ["id"] = Guid.Empty,
            ["scheduleDayId"] = day.Id,
            ["name"] = "Controller Timed Exercise",
            ["description"] = "Controller exercise create",
            ["workoutTime"] = TimeSpan.FromMinutes(25),
            ["startTime"] = new TimeOnly(9, 0),
            ["weight"] = 17.5m
        };

        var createResponse = await _client.PostAsJsonAsync("/api/Exercise", createPayload);
        Assert.Equal(HttpStatusCode.OK, createResponse.StatusCode);

        var createResult = await createResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<JsonElement>>();
        Assert.NotNull(createResult);
        Assert.True(createResult!.Success);

        var exerciseId = createResult.Data.GetProperty("id").GetGuid();
        Assert.NotEqual(Guid.Empty, exerciseId);

        var getByIdResponse = await _client.GetAsync($"/api/Exercise/{exerciseId}");
        var getByIdResult = await getByIdResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<JsonElement>>();
        Assert.NotNull(getByIdResult);
        Assert.True(getByIdResult!.Success);
        Assert.Equal(exerciseId, getByIdResult.Data.GetProperty("id").GetGuid());

        var updatePayload = new Dictionary<string, object?>
        {
            ["$type"] = "timed",
            ["id"] = exerciseId,
            ["scheduleDayId"] = day.Id,
            ["name"] = "Controller Updated Timed Exercise",
            ["description"] = "Controller exercise update",
            ["workoutTime"] = TimeSpan.FromMinutes(35),
            ["startTime"] = new TimeOnly(10, 0),
            ["weight"] = 22.25m
        };

        var updateResponse = await _client.PutAsJsonAsync($"/api/Exercise/{exerciseId}", updatePayload);
        var updateResult = await updateResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<JsonElement>>();
        Assert.NotNull(updateResult);
        Assert.True(updateResult!.Success);

        var getAfterUpdateResponse = await _client.GetAsync($"/api/Exercise/{exerciseId}");
        var getAfterUpdateResult = await getAfterUpdateResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<JsonElement>>();
        Assert.NotNull(getAfterUpdateResult);
        Assert.True(getAfterUpdateResult!.Success);
        Assert.Equal("Controller Updated Timed Exercise", getAfterUpdateResult.Data.GetProperty("name").GetString());

        var listByDayResponse = await _client.GetAsync($"/api/Exercise/scheduleDay/{day.Id}");
        var listByDayResult = await listByDayResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<List<JsonElement>>>();
        Assert.NotNull(listByDayResult);
        Assert.True(listByDayResult!.Success);
        Assert.Single(listByDayResult.Data);

        var deleteResponse = await _client.DeleteAsync($"/api/Exercise/{exerciseId}");
        var deleteResult = await deleteResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<bool>>();
        Assert.NotNull(deleteResult);
        Assert.True(deleteResult!.Success);

        var getAfterDeleteResponse = await _client.GetAsync($"/api/Exercise/{exerciseId}");
        var getAfterDeleteResult = await getAfterDeleteResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<JsonElement>>();
        Assert.NotNull(getAfterDeleteResult);
        Assert.False(getAfterDeleteResult!.Success);
        Assert.Equal(404, getAfterDeleteResult.StatusCode);
    }
}
