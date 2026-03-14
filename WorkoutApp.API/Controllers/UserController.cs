using Microsoft.AspNetCore.Mvc;
using WorkoutApp.API.Models;
using WorkoutApp.API.Models.Results;
using WorkoutApp.API.Services;

namespace WorkoutApp.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class UserController(IUserService userService) : ControllerBase
{
    [HttpGet("email/{email}")]
    public async Task<ServiceResult<User>> GetUserByEmail(string email) => await userService.GetUserByEmailAsync(email);

    [HttpGet("{id}")]
    public async Task<ServiceResult<User>> GetUserById(Guid id) => await userService.GetUserByIdAsync(id);

    [HttpPost]
    public async Task<ServiceResult<User>> CreateUser(User user) => await userService.CreateUserAsync(user);

    [HttpPut("{id}")]
    public async Task<ServiceResult<User>> UpdateUser(Guid id, User user) => await userService.UpdateUserAsync(user);

    [HttpDelete("{id}")]
    public async Task<ServiceResult<bool>> DeleteUser(Guid id) => await userService.DeleteUserAsync(id);
}