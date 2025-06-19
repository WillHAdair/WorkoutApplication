namespace WorkoutAPI.Models
{
    public class WorkoutSchedule
    {
        public int ID { get; set; }
        public required string Name { get; set; }
        public string Description { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public List<ScheduleDay> Days { get; set; }
        public WorkoutSchedule() { }
        public WorkoutSchedule(int id, string name, string description, DateTime startDate, DateTime? endDate, List<ScheduleDay> days)
        {
            ID = id;
            Name = name;
            Description = description;
            StartDate = startDate;
            EndDate = endDate;
            Days = days;
        }
        public bool IsActive()
        {
            return EndDate == null || EndDate.Value.Date <= DateTime.Today;
        }

        public ScheduleDay GetActiveDay()
        {
            int daysSinceStart = (DateTime.Today - StartDate.Date).Days;
            if (daysSinceStart < 0)
                daysSinceStart = 0;
            return Days[daysSinceStart % Days.Count];
        }
    }
}
