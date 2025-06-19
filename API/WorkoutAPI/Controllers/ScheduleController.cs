using Microsoft.AspNetCore.Mvc;

namespace WorkoutAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ScheduleController : ControllerBase
    {
        [HttpGet]
        public IActionResult GetAllSchedules()
        {
            return Ok(TestData.TestData.schedules);
        }

        [HttpGet("{id}")]
        public IActionResult GetScheduleById(int id)
        {
            var schedule = TestData.TestData.schedules.FirstOrDefault(s => s.ID == id);
            if (schedule == null)
            {
                return NotFound();
            }
            return Ok(schedule);
        }

        [HttpPost]
        public IActionResult CreateSchedule([FromBody] Models.WorkoutSchedule schedule)
        {
            if (schedule == null)
            {
                return BadRequest("Schedule cannot be null.");
            }
            // Assign a new ID to the schedule
            schedule.ID = TestData.TestData.schedules.Count > 0 ? TestData.TestData.schedules.Max(s => s.ID) + 1 : 1;
            TestData.TestData.schedules.Add(schedule);
            return CreatedAtAction(nameof(GetScheduleById), new { id = schedule.ID }, schedule);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateSchedule(int id, [FromBody] Models.WorkoutSchedule updatedSchedule)
        {
            if (updatedSchedule == null)
            {
                return BadRequest("Updated schedule cannot be null.");
            }
            var existingSchedule = TestData.TestData.schedules.FirstOrDefault(s => s.ID == id);
            if (existingSchedule == null)
            {
                return NotFound();
            }
            // Update the existing schedule
            existingSchedule.Name = updatedSchedule.Name;
            existingSchedule.Description = updatedSchedule.Description;
            existingSchedule.Days = updatedSchedule.Days;
            return NoContent();
        }
    }
}
