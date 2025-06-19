using Microsoft.AspNetCore.Mvc;
using WorkoutAPI.Models;

namespace WorkoutAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class WorkoutController : ControllerBase
    {
        [HttpGet]
        public IActionResult GetAllWorkouts()
        {
            return Ok(TestData.TestData.workouts);
        }

        [HttpGet("{id}")]
        public IActionResult GetWorkoutById(int id)
        {
            var workout = TestData.TestData.workouts.FirstOrDefault(w => w.ID == id);
            if (workout == null)
            {
                return NotFound();
            }
            return Ok(workout);
        }

        [HttpPost]
        public IActionResult CreateWorkout([FromBody] Workout workout)
        {
            if (workout == null)
            {
                return BadRequest("Workout cannot be null.");
            }
            // Assign a new ID to the workout
            workout.ID = TestData.TestData.workouts.Count > 0 ? TestData.TestData.workouts.Max(w => w.ID) + 1 : 1;
            TestData.TestData.workouts.Add(workout);
            return CreatedAtAction(nameof(GetWorkoutById), new { id = workout.ID }, workout);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateWorkout(int id, [FromBody] Workout updatedWorkout)
        {
            if (updatedWorkout == null)
            {
                return BadRequest("Updated workout cannot be null.");
            }
            var existingWorkout = TestData.TestData.workouts.FirstOrDefault(w => w.ID == id);
            if (existingWorkout == null)
            {
                return NotFound();
            }
            // Update the existing workout
            existingWorkout.Name = updatedWorkout.Name;
            existingWorkout.Description = updatedWorkout.Description;
            if (existingWorkout is TimedWorkout timedWorkout && updatedWorkout is TimedWorkout newTimedWorkout)
            {
                timedWorkout.Time = newTimedWorkout.Time;
                timedWorkout.Weight = newTimedWorkout.Weight;
            }
            else if (existingWorkout is ExercisesWorkout exercisesWorkout && updatedWorkout is ExercisesWorkout newExercisesWorkout)
            {
                exercisesWorkout.Exercises = newExercisesWorkout.Exercises;
                exercisesWorkout.RestTime = newExercisesWorkout.RestTime;
            }
            return NoContent();
        }
    }
}
