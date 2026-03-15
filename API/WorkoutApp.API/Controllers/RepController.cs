using Microsoft.AspNetCore.Mvc;
using WorkoutApp.API.Models;
using WorkoutApp.API.Models.Results;
using WorkoutApp.API.Services;

namespace WorkoutApp.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class RepController(IRepService workoutRepService) : ControllerBase
{
    [HttpGet("{id}")]
    public async Task<ServiceResult<Rep>> GetWorkoutRepititionById(Guid id) => await workoutRepService.GetWorkoutRepititionByIdAsync(id);

    [HttpGet("exercise/{exerciseId}")]
    public async Task<ServiceResult<List<Rep>>> GetWorkoutRepititionsByExerciseId(Guid exerciseId) => await workoutRepService.GetWorkoutRepititionsByExerciseIdAsync(exerciseId);

    [HttpPost]
    public async Task<ServiceResult<Rep>> CreateWorkoutRepitition(Rep workoutRepitition) => await workoutRepService.CreateWorkoutRepititionAsync(workoutRepitition);

    [HttpPut("{id}")]
    public async Task<ServiceResult<Rep>> UpdateWorkoutRepitition(Guid id, Rep workoutRepitition) => await workoutRepService.UpdateWorkoutRepititionAsync(workoutRepitition);

    [HttpDelete("{id}")]
    public async Task<ServiceResult<bool>> DeleteWorkoutRepitition(Guid id) => await workoutRepService.DeleteWorkoutRepititionAsync(id);
}
