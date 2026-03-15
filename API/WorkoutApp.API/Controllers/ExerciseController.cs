using Microsoft.AspNetCore.Mvc;
using WorkoutApp.API.Models;
using WorkoutApp.API.Models.Results;
using WorkoutApp.API.Services;

namespace WorkoutApp.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ExerciseController(IExerciseService workoutExerciseService) : ControllerBase
{
    [HttpGet("{id}")]
    public async Task<ServiceResult<Exercise>> GetWorkoutExerciseById(Guid id) => await workoutExerciseService.GetWorkoutExerciseByIdAsync(id);

    [HttpGet("scheduleDay/{scheduleDayId}")]
    public async Task<ServiceResult<List<Exercise>>> GetWorkoutExercisesByScheduleDayId(Guid scheduleDayId) => await workoutExerciseService.GetWorkoutExercisesByScheduleDayIdAsync(scheduleDayId);

    [HttpPost]
    public async Task<ServiceResult<Exercise>> CreateWorkoutExercise(Exercise workoutExercise) => await workoutExerciseService.CreateWorkoutExerciseAsync(workoutExercise);

    [HttpPut("{id}")]
    public async Task<ServiceResult<Exercise>> UpdateWorkoutExercise(Guid id, Exercise workoutExercise) => await workoutExerciseService.UpdateWorkoutExerciseAsync(workoutExercise);

    [HttpDelete("{id}")]
    public async Task<ServiceResult<bool>> DeleteWorkoutExercise(Guid id) => await workoutExerciseService.DeleteWorkoutExerciseAsync(id);
}
