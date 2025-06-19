namespace WorkoutAPI.Models
{
    public class UserProfile
    {
        public required string UserName { get; set; }
        public double Height { get; set; } // Measured in inches
        public double Weight { get; set; } // Measured in pounds
        public WorkoutHistory History { get; set; }
        public List<WorkoutSchedule> Schedules { get; set; }
        public UserProfile() { }
        public UserProfile(string userName, double height, double weight, WorkoutHistory history, List<WorkoutSchedule> schedules)
        {
            UserName = userName;
            Height = height;
            Weight = weight;
            History = history;
            Schedules = schedules;
        }
    }
}
