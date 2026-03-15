using System.Net;
using System.Net.Http.Json;
using System.Text.Json;
using WorkoutApp.API.Models;
using WorkoutApp.API.Test.TestData;
using WorkoutApp.API.Test.TestInfrastructure;

namespace WorkoutApp.API.Test.Controller;

public class RepControllerIntegrationTests : IClassFixture<SqlServerContainerFixture>, IAsyncLifetime, IDisposable
{
    private readonly SqlServerContainerFixture _fixture;
    private readonly TestApiWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public RepControllerIntegrationTests(SqlServerContainerFixture fixture)
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
    public async Task CreateReadUpdateDeleteFlow_ShouldHandlePolymorphicRepPayloads()
    {
        await using var db = _fixture.CreateDbContext();
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

        var createPayload = new Dictionary<string, object?>
        {
            ["$type"] = "counted",
            ["id"] = Guid.Empty,
            ["exerciseId"] = setExercise.Id,
            ["name"] = "Controller Counted Rep",
            ["description"] = "Controller rep create",
            ["count"] = 10,
            ["weight"] = 42.5m,
            ["restPeriod"] = TimeSpan.FromSeconds(50)
        };

        var createResponse = await _client.PostAsJsonAsync("/api/Rep", createPayload);
        Assert.Equal(HttpStatusCode.OK, createResponse.StatusCode);

        var createResult = await createResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<JsonElement>>();
        Assert.NotNull(createResult);
        Assert.True(createResult!.Success);

        var repId = createResult.Data.GetProperty("id").GetGuid();
        Assert.NotEqual(Guid.Empty, repId);

        var getByIdResponse = await _client.GetAsync($"/api/Rep/{repId}");
        var getByIdResult = await getByIdResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<JsonElement>>();
        Assert.NotNull(getByIdResult);
        Assert.True(getByIdResult!.Success);
        Assert.Equal(repId, getByIdResult.Data.GetProperty("id").GetGuid());

        var updatePayload = new Dictionary<string, object?>
        {
            ["$type"] = "counted",
            ["id"] = repId,
            ["exerciseId"] = setExercise.Id,
            ["name"] = "Controller Updated Counted Rep",
            ["description"] = "Controller rep update",
            ["count"] = 16,
            ["weight"] = 50.0m,
            ["restPeriod"] = TimeSpan.FromSeconds(70)
        };

        var updateResponse = await _client.PutAsJsonAsync($"/api/Rep/{repId}", updatePayload);
        var updateResult = await updateResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<JsonElement>>();
        Assert.NotNull(updateResult);
        Assert.True(updateResult!.Success);
        Assert.Equal("Controller Updated Counted Rep", updateResult.Data.GetProperty("name").GetString());

        var listByExerciseResponse = await _client.GetAsync($"/api/Rep/exercise/{setExercise.Id}");
        var listByExerciseResult = await listByExerciseResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<List<JsonElement>>>();
        Assert.NotNull(listByExerciseResult);
        Assert.True(listByExerciseResult!.Success);
        Assert.Single(listByExerciseResult.Data);

        var deleteResponse = await _client.DeleteAsync($"/api/Rep/{repId}");
        var deleteResult = await deleteResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<bool>>();
        Assert.NotNull(deleteResult);
        Assert.True(deleteResult!.Success);

        var getAfterDeleteResponse = await _client.GetAsync($"/api/Rep/{repId}");
        var getAfterDeleteResult = await getAfterDeleteResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<JsonElement>>();
        Assert.NotNull(getAfterDeleteResult);
        Assert.False(getAfterDeleteResult!.Success);
        Assert.Equal(404, getAfterDeleteResult.StatusCode);
    }
}
