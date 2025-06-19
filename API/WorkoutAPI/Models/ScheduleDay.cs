namespace WorkoutAPI.Models
{
    public class ScheduleDay
    {
        public int ID { get; set; }
        public int WorkoutSchduleID { get; set; } // Schedule days cannot be shared across schedules
        public required string Name { get; set; }
        public string Description { get; set; }
        public List<Workout> Workouts { get; set; } // When empty, this is assumed to be a rest day
        public double? CalorieGoal { get; set; } // When null, default calorie goal is assumed
        public TimeOnly? WorkoutTime { get; set; } // This is for the time of day expected for a workout (if null then no warning/expected time).
        public ScheduleDay() { }
        public ScheduleDay(int id, int workoutScheduleID, string name, string description, List<Workout> workouts, double? calorieGoal, TimeOnly? workoutTime)
        {
            ID = id;
            WorkoutSchduleID = workoutScheduleID;
            Name = name;
            Description = description;
            Workouts = workouts;
            CalorieGoal = calorieGoal;
            WorkoutTime = workoutTime;
        }
    }
}
