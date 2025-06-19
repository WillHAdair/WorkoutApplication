namespace WorkoutAPI.Models
{
    public enum CompletionStatus
    {
        Completed,
        Skipped,
        Partial
    }
    public class WorkoutHistory
    {
        public (Workout?, double? completionStatus) ActiveWorkout { get; set; }
        public List<PastScheduleDays> ScheduleHistory { get; set; }
        public WorkoutHistory()
        {
            ActiveWorkout = (null, null);
            ScheduleHistory = [];
        }
        public WorkoutHistory((Workout?, double? completionStatus) activeWorkout, List<PastScheduleDays> scheduleHistory)
        {
            ActiveWorkout = activeWorkout;
            ScheduleHistory = scheduleHistory;
        }
    }
    public class PastScheduleDays
    {
        public int ID { get; set; }
        public int ScheduleID { get; set; }
        public PastWorkoutDay? Workouts { get; set; } // if null, then no workouts were done that day (rest or skip day).
        public DateOnly Day { get; set; }
        public TimeOnly? WorkoutStart { get; set; }
        public TimeOnly? WorkoutEnd { get; set; }
        public PastScheduleDays() { }
        public PastScheduleDays(int id, int scheduleID, PastWorkoutDay? workouts, DateOnly day, TimeOnly? workoutStart, TimeOnly? workoutEnd)
        {
            ID = id;
            ScheduleID = scheduleID;
            Workouts = workouts;
            Day = day;
            WorkoutStart = workoutStart;
            WorkoutEnd = workoutEnd;
        }
    }

    public class PastWorkoutDay
    {
        public List<int> WorkoutIDs;
        public List<double> CompletedWorkoutsStatus; // If there is less in completionStatus, it is assumed the following workout(s) were not completed.
        public PastWorkoutDay() { }
        public PastWorkoutDay(List<int> workoutIDs, List<double> completionStatus)
        {
            WorkoutIDs = workoutIDs;
            CompletedWorkoutsStatus = completionStatus;
        }

        public bool IsComplete()
        {
            if (WorkoutIDs.Count == 0 || CompletedWorkoutsStatus.Count == 0 || WorkoutIDs.Count != CompletedWorkoutsStatus.Count) return false;
            for (int i = 0; i < CompletedWorkoutsStatus.Count; i++)
            {
                if (CompletedWorkoutsStatus[i] < 100.0) return false;
            }
            return true;
        }
    }
}
