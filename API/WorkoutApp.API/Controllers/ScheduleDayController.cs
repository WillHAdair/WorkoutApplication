using Microsoft.AspNetCore.Mvc;
using WorkoutApp.API.Models;
using WorkoutApp.API.Models.Results;
using WorkoutApp.API.Services;

namespace WorkoutApp.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ScheduleDayController(IScheduleDayService scheduleDayService) : ControllerBase
{
    [HttpGet("{id}")]
    public async Task<ServiceResult<ScheduleDay>> GetScheduleDayById(Guid id) => await scheduleDayService.GetScheduleDayByIdAsync(id);

    [HttpGet("schedule/{scheduleId}")]
    public async Task<ServiceResult<List<ScheduleDay>>> GetScheduleDaysByScheduleId(Guid scheduleId) => await scheduleDayService.GetScheduleDaysByScheduleIdAsync(scheduleId);

    [HttpGet("schedule/{scheduleId}/date/{date}")]
    public async Task<ServiceResult<ScheduleDay>> GetScheduleDayForDay(Guid scheduleId, DateOnly date) => await scheduleDayService.GetScheduleDayForDayAsync(scheduleId, date);

    [HttpPost]
    public async Task<ServiceResult<ScheduleDay>> CreateScheduleDay(ScheduleDay scheduleDay) => await scheduleDayService.CreateScheduleDayAsync(scheduleDay);

    [HttpPut("{id}")]
    public async Task<ServiceResult<ScheduleDay>> UpdateScheduleDay(Guid id, ScheduleDay scheduleDay) => await scheduleDayService.UpdateScheduleDayAsync(scheduleDay);

    [HttpDelete("{id}")]
    public async Task<ServiceResult<bool>> DeleteScheduleDay(Guid id) => await scheduleDayService.DeleteScheduleDayAsync(id);
}
