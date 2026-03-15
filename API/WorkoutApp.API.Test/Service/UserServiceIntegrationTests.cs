using Microsoft.EntityFrameworkCore;
using WorkoutApp.API.Models.Results;
using WorkoutApp.API.Services;
using WorkoutApp.API.Test.TestData;
using WorkoutApp.API.Test.TestInfrastructure;

namespace WorkoutApp.API.Test.Service;

public class UserServiceIntegrationTests(SqlServerContainerFixture fixture)
    : IClassFixture<SqlServerContainerFixture>, IAsyncLifetime
{
    private readonly SqlServerContainerFixture _fixture = fixture;

    public Task InitializeAsync() => _fixture.ResetDatabaseAsync();

    public Task DisposeAsync() => Task.CompletedTask;

    [Fact]
    public async Task CreateUserAsync_ShouldPersistUserInDatabase()
    {
        await using var dbContext = _fixture.CreateDbContext();
        var service = new UserService(dbContext);
        var user = UserTestData.CreateUser();

        var result = await service.CreateUserAsync(user);

        Assert.IsType<CreatedResult<WorkoutApp.API.Models.User>>(result);
        Assert.True(result.Success);

        var persistedUser = await dbContext.Users.FindAsync(user.Id);
        Assert.NotNull(persistedUser);
        Assert.Equal(user.Email, persistedUser!.Email);
    }

    [Fact]
    public async Task UpdateUserAsync_ShouldUpdateExistingUser()
    {
        await using var dbContext = _fixture.CreateDbContext();
        var service = new UserService(dbContext);

        var user = UserTestData.CreateUser();
        await dbContext.Users.AddAsync(user);
        await dbContext.SaveChangesAsync();

        var updatedName = "Updated Name";
        var updatedEmail = "updated.user@example.com";

        var updatedUser = new WorkoutApp.API.Models.User
        {
            Id = user.Id,
            Name = updatedName,
            Description = user.Description,
            Username = user.Username,
            Email = updatedEmail,
            PasswordHash = user.PasswordHash,
            BaseUnit = user.BaseUnit
        };

        var result = await service.UpdateUserAsync(updatedUser);

        Assert.True(result.Success);
        var persistedUser = await dbContext.Users.AsNoTracking().SingleAsync(u => u.Id == user.Id);
        Assert.Equal(updatedName, persistedUser.Name);
        Assert.Equal(updatedEmail, persistedUser.Email);
    }

    [Fact]
    public async Task DeleteUserAsync_ShouldRemoveUserFromDatabase()
    {
        await using var dbContext = _fixture.CreateDbContext();
        var service = new UserService(dbContext);

        var user = UserTestData.CreateUser();
        await dbContext.Users.AddAsync(user);
        await dbContext.SaveChangesAsync();

        var result = await service.DeleteUserAsync(user.Id);

        Assert.True(result.Success);

        var persistedUser = await dbContext.Users.FindAsync(user.Id);
        Assert.Null(persistedUser);
    }
}
