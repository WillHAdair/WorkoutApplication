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
        public Workout? ActiveWorkout { get; set; }

    }
    public class ScheduleHistory
    {
        public int ID { get; set; }
        public int ScheduleID { get; set; }
        public List<int> WorkoutIDs { get; set; }
        public DateOnly Day {  get; set; }
        public TimeOnly? WorkoutStart { get; set; }
        public TimeOnly? WorkoutEnd { get; set; }
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
            return false;
        }
    }
}
