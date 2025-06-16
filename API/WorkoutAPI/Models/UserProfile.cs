namespace WorkoutAPI.Models
{
    public class UserProfile
    {
        public required string UserName { get; set; }
        public double Height { get; set; } // Measure in inches
        public double Weight { get; set; } // Measured in pounds
        public WorkoutHistory History { get; set; }
        public List<WorkoutSchedule> Schedules { get; set; }
        public UserSettings Settings { get; set; }
        public UserProfile() { }
        public UserProfile(string userName, double height, double weight, WorkoutHistory history, List<WorkoutSchedule> schedules, UserSettings settings)
        {
            UserName = userName;
            Height = height;
            Weight = weight;
            History = history;
            Schedules = schedules;
            Settings = settings;
        }
    }
}
