using System.Net;
using System.Net.Http.Json;
using WorkoutApp.API.Models;
using WorkoutApp.API.Test.TestData;
using WorkoutApp.API.Test.TestInfrastructure;

namespace WorkoutApp.API.Test.Controller;

public class UserControllerIntegrationTests : IClassFixture<SqlServerContainerFixture>, IAsyncLifetime, IDisposable
{
    private readonly SqlServerContainerFixture _fixture;
    private readonly TestApiWebApplicationFactory _factory;
    private readonly HttpClient _client;

    public UserControllerIntegrationTests(SqlServerContainerFixture fixture)
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
    public async Task CreateUpdateDeleteFlow_ShouldSucceedAgainstContainerizedDatabase()
    {
        var newUser = UserTestData.CreateUser();

        var createResponse = await _client.PostAsJsonAsync("/api/User", newUser);
        Assert.Equal(HttpStatusCode.OK, createResponse.StatusCode);

        var createPayload = await createResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<User>>();
        Assert.NotNull(createPayload);
        Assert.True(createPayload!.Success);
        Assert.Equal(201, createPayload.StatusCode);
        Assert.Equal(newUser.Id, createPayload.Data.Id);

        var getResponse = await _client.GetAsync($"/api/User/{newUser.Id}");
        Assert.Equal(HttpStatusCode.OK, getResponse.StatusCode);

        var getPayload = await getResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<User>>();
        Assert.NotNull(getPayload);
        Assert.True(getPayload!.Success);
        Assert.Equal(newUser.Email, getPayload.Data.Email);

        var updatedUser = new User
        {
            Id = newUser.Id,
            Name = "Updated Endpoint User",
            Description = newUser.Description,
            Username = newUser.Username,
            Email = "updated.endpoint.user@example.com",
            PasswordHash = newUser.PasswordHash,
            BaseUnit = newUser.BaseUnit
        };

        var updateResponse = await _client.PutAsJsonAsync($"/api/User/{newUser.Id}", updatedUser);
        Assert.Equal(HttpStatusCode.OK, updateResponse.StatusCode);

        var updatePayload = await updateResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<User>>();
        Assert.NotNull(updatePayload);
        Assert.True(updatePayload!.Success);
        Assert.Equal(updatedUser.Email, updatePayload.Data.Email);

        var deleteResponse = await _client.DeleteAsync($"/api/User/{newUser.Id}");
        Assert.Equal(HttpStatusCode.OK, deleteResponse.StatusCode);

        var deletePayload = await deleteResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<bool>>();
        Assert.NotNull(deletePayload);
        Assert.True(deletePayload!.Success);
        Assert.True(deletePayload.Data);

        var getAfterDeleteResponse = await _client.GetAsync($"/api/User/{newUser.Id}");
        Assert.Equal(HttpStatusCode.OK, getAfterDeleteResponse.StatusCode);

        var getAfterDeletePayload = await getAfterDeleteResponse.Content.ReadFromJsonAsync<ServiceResultEnvelope<User>>();
        Assert.NotNull(getAfterDeletePayload);
        Assert.False(getAfterDeletePayload!.Success);
        Assert.Equal(404, getAfterDeletePayload.StatusCode);
    }
}
