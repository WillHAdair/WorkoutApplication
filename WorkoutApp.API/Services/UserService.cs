using Microsoft.EntityFrameworkCore;
using WorkoutApp.API.Database;
using WorkoutApp.API.Models;
using WorkoutApp.API.Models.Results;

namespace WorkoutApp.API.Services;

public interface IUserService
{
    Task<ServiceResult<User>> GetUserByEmailAsync(string email);
    Task<ServiceResult<User>> GetUserByIdAsync(Guid id);
    Task<ServiceResult<User>> CreateUserAsync(User user);
    Task<ServiceResult<User>> UpdateUserAsync(User user);
    Task<ServiceResult<bool>> DeleteUserAsync(Guid id);
}

public class UserService(WorkoutAppDbContext context) : IUserService
{
    private readonly string InternalServerErrorMessage = "An error occurred while processing your request.";
    public async Task<ServiceResult<User>> GetUserByEmailAsync(string email)
    {
        try
        {
            var user = await context.Users.FirstOrDefaultAsync(u => u.Email == email);
            if (user == null)
                return new NotFoundResult<User>("User not found.");
            return new SuccessResult<User>(user);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<User>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<User>> GetUserByIdAsync(Guid id)
    {
        try
        {
            var user = await context.Users.FindAsync(id);
            if (user == null)
                return new NotFoundResult<User>("User not found.");
            return new SuccessResult<User>(user);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<User>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<User>> CreateUserAsync(User user)
    {
        try
        {
            await context.Users.AddAsync(user);
            await context.SaveChangesAsync();
            return new CreatedResult<User>(user);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<User>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<User>> UpdateUserAsync(User user)
    {
        try
        {
            var existingUser = await context.Users.FindAsync(user.Id);
            if (existingUser == null)
            {
                return new NotFoundResult<User>("User not found.");
            }

            existingUser.Name = user.Name;
            existingUser.Email = user.Email;

            context.Users.Update(existingUser);
            await context.SaveChangesAsync();

            return new SuccessResult<User>(existingUser);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<User>(InternalServerErrorMessage);
        }
    }

    public async Task<ServiceResult<bool>> DeleteUserAsync(Guid id)
    {
        try
        {
            var user = await context.Users.FindAsync(id);
            if (user == null)
            {
                return new NotFoundResult<bool>("User not found.");
            }

            context.Users.Remove(user);
            await context.SaveChangesAsync();

            return new SuccessResult<bool>(true);
        }
        catch (Exception ex)
        {
            return new InternalServerErrorResult<bool>(InternalServerErrorMessage);
        }
    }
}