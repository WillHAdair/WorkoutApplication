using Microsoft.AspNetCore.Mvc;
using WorkoutApp.API.Models;
using WorkoutApp.API.Models.Results;
using WorkoutApp.API.Services;

namespace WorkoutApp.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class WorkoutScheduleController(IWorkoutScheduleService workoutScheduleService) : ControllerBase
{
    [HttpGet("{id}")]
    public async Task<ServiceResult<WorkoutSchedule>> GetScheduleById(Guid id) => await workoutScheduleService.GetScheduleByIdAsync(id);

    [HttpGet("user/{userId}/active")]
    public async Task<ServiceResult<List<WorkoutSchedule>>> GetActiveSchedulesByUserId(Guid userId) => await workoutScheduleService.GetActiveSchedulesByUserIdAsync(userId);

    [HttpGet("user/{userId}")]
    public async Task<ServiceResult<List<WorkoutSchedule>>> GetSchedulesByUserId(Guid userId) => await workoutScheduleService.GetSchedulesByUserIdAsync(userId);

    [HttpPost]
    public async Task<ServiceResult<WorkoutSchedule>> CreateSchedule(WorkoutSchedule schedule) => await workoutScheduleService.CreateScheduleAsync(schedule);

    [HttpPut("{id}")]
    public async Task<ServiceResult<WorkoutSchedule>> UpdateSchedule(Guid id, WorkoutSchedule schedule) => await workoutScheduleService.UpdateScheduleAsync(schedule);

    [HttpDelete("{id}")]
    public async Task<ServiceResult<bool>> DeleteSchedule(Guid id) => await workoutScheduleService.DeleteScheduleAsync(id);
}
