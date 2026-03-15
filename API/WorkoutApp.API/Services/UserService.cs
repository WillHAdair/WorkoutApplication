using Microsoft.EntityFrameworkCore;
using WorkoutApp.API.Database;
using WorkoutApp.API.Models;
using WorkoutApp.API.Models.Results;

namespace WorkoutApp.API.Services;

public interface IUserService
{
    Task<ServiceResult<User>> GetUserByEmailAsync(string email, CancellationToken token = default);
    Task<ServiceResult<User>> GetUserByIdAsync(Guid id, CancellationToken token = default);
    Task<ServiceResult<User>> CreateUserAsync(User user, CancellationToken token = default);
    Task<ServiceResult<User>> UpdateUserAsync(User user, CancellationToken token = default);
    Task<ServiceResult<bool>> DeleteUserAsync(Guid id, CancellationToken token = default);
}

public class UserService(WorkoutAppDbContext context) : IUserService
{
    private readonly string InternalServerErrorMessage = "An error occurred while processing your request.";
    public async Task<ServiceResult<User>> GetUserByEmailAsync(string email, CancellationToken token = default)
    {
        try
        {
            var user = await context.Users.FirstOrDefaultAsync(u => u.Email == email, token);
            if (user == null)
                return new NotFoundResult<User>("User not found.");
            return new SuccessResult<User>(user);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<User>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<User>> GetUserByIdAsync(Guid id, CancellationToken token = default)
    {
        try
        {
            var user = await context.Users.FindAsync([id], token);
            if (user == null)
                return new NotFoundResult<User>("User not found.");
            return new SuccessResult<User>(user);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<User>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<User>> CreateUserAsync(User user, CancellationToken token = default)
    {
        try
        {
            await context.Users.AddAsync(user, token);
            await context.SaveChangesAsync(token);

            return new CreatedResult<User>(user);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<User>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<User>> UpdateUserAsync(User user, CancellationToken token = default)
    {
        try
        {
            var existingUser = await context.Users.FindAsync([user.Id], token);
            if (existingUser == null)
            {
                return new NotFoundResult<User>("User not found.");
            }

            existingUser.Name = user.Name;
            existingUser.Email = user.Email;

            context.Users.Update(existingUser);
            await context.SaveChangesAsync(token);

            return new SuccessResult<User>(existingUser);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<User>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<bool>> DeleteUserAsync(Guid id, CancellationToken token = default)
    {
        try
        {
            var user = await context.Users.FindAsync([id], token);
            if (user == null)
            {
                return new NotFoundResult<bool>("User not found.");
            }

            context.Users.Remove(user);
            await context.SaveChangesAsync(token);

            return new SuccessResult<bool>(true);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<bool>(InternalServerErrorMessage);
        }
    }
}