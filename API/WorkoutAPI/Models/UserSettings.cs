namespace WorkoutAPI.Models
{
    public class UserSettings
    {
        public bool IsDarkMode { get; set; }
        public bool AllowAI { get; set; }
        public bool TrackCalories { get; set; }
        public bool AllowPushNotifications { get; set; }
        public UserSettings() { }
        public UserSettings(bool isDarkMode, bool allowAI, bool trackCalories, bool allowPushNotifications)
        {
            IsDarkMode = isDarkMode;
            AllowAI = allowAI;
            TrackCalories = trackCalories;
            AllowPushNotifications = allowPushNotifications;
        }
    }
}
