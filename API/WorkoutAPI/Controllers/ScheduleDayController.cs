namespace WorkoutAPI.Controllers
{
    using Microsoft.AspNetCore.Mvc;
    using WorkoutAPI.Models;
    using WorkoutAPI.TestData;

    [ApiController]
    [Route("[controller]")]
    public class ScheduleDayController : ControllerBase
    {
        [HttpGet]
        public IActionResult GetScheduleDays()
        {
            return Ok(TestData.days);
        }

        [HttpGet("{id}")]
        public IActionResult GetScheduleDayById(int id)
        {
            var scheduleDay = TestData.days.FirstOrDefault(sd => sd.ID == id);
            if (scheduleDay == null)
            {
                return NotFound();
            }
            return Ok(scheduleDay);
        }

        [HttpPost]
        public IActionResult CreateScheduleDay([FromBody] ScheduleDay scheduleDay)
        {
            if (scheduleDay == null)
            {
                return BadRequest("Schedule day cannot be null.");
            }
            // Assign a new ID to the schedule day
            scheduleDay.ID = TestData.days.Count > 0 ? TestData.days.Max(sd => sd.ID) + 1 : 1;
            TestData.days.Add(scheduleDay);
            return CreatedAtAction(nameof(GetScheduleDayById), new { id = scheduleDay.ID }, scheduleDay);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateScheduleDay(int id, [FromBody] ScheduleDay updatedScheduleDay)
        {
            if (updatedScheduleDay == null)
            {
                return BadRequest("Updated schedule day cannot be null.");
            }
            var existingScheduleDay = TestData.days.FirstOrDefault(sd => sd.ID == id);
            if (existingScheduleDay == null)
            {
                return NotFound();
            }
            // Update the existing schedule day
            existingScheduleDay.Name = updatedScheduleDay.Name;
            existingScheduleDay.Description = updatedScheduleDay.Description;
            existingScheduleDay.Workouts = updatedScheduleDay.Workouts;
            return NoContent();
        }
    }
}
