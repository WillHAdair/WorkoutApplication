using Microsoft.AspNetCore.Mvc;

namespace WorkoutAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ExercisesController : ControllerBase
    {
        [HttpGet]
        public IActionResult GetAllExercises()
        {
            return Ok(TestData.TestData.exercises);
        }

        [HttpGet("{id}")]
        public IActionResult GetExerciseById(int id)
        {
            var exercise = TestData.TestData.exercises.FirstOrDefault(e => e.ID == id);
            if (exercise == null)
            {
                return NotFound();
            }
            return Ok(exercise);
        }

        [HttpPost]
        public IActionResult CreateExercise([FromBody] Models.Exercise exercise)
        {
            if (exercise == null)
            {
                return BadRequest("Exercise cannot be null.");
            }
            // Assign a new ID to the exercise
            exercise.ID = TestData.TestData.exercises.Count > 0 ? TestData.TestData.exercises.Max(e => e.ID) + 1 : 1;
            TestData.TestData.exercises.Add(exercise);
            return CreatedAtAction(nameof(GetExerciseById), new { id = exercise.ID }, exercise);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateExercise(int id, [FromBody] Models.Exercise updatedExercise)
        {
            if (updatedExercise == null)
            {
                return BadRequest("Updated exercise cannot be null.");
            }
            var existingExercise = TestData.TestData.exercises.FirstOrDefault(e => e.ID == id);
            if (existingExercise == null)
            {
                return NotFound();
            }
            // Update the existing exercise
            existingExercise.Name = updatedExercise.Name;
            existingExercise.Description = updatedExercise.Description;
            existingExercise.RestTime = updatedExercise.RestTime;
            if (existingExercise is Models.TimedExercise timedExercise && updatedExercise is Models.TimedExercise newTimedExercise)
            {
                timedExercise.Time = newTimedExercise.Time;
                timedExercise.Weight = newTimedExercise.Weight;
            }
            else if (existingExercise is Models.SetsExercise setsExercise && updatedExercise is Models.SetsExercise newSetsExercise)
            {
                setsExercise.Sets = newSetsExercise.Sets;
            }
            else if (existingExercise is Models.CircuitExercise circuitExercise && updatedExercise is Models.CircuitExercise newCircuitExercise)
            {
                circuitExercise.Exercises = newCircuitExercise.Exercises;
            }
            return NoContent();
        }
    }
}
