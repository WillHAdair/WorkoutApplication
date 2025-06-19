namespace WorkoutAPI.Models
{
    public abstract class Workout
    {
        public int ID { get; set; }
        public required string Name { get; set; }
        public string? Description { get; set; }
    }

    // This type of workout just has a timer associated with it.
    public class TimedWorkout : Workout
    {
        public double Time { get; set; }
        public double? Weight { get; set; }

        public TimedWorkout() { }
        public TimedWorkout(int id, string name, string description, double time, double? weight)
        {
            this.ID = id;
            this.Name = name;
            this.Description = description;
            this.Time = time;
            this.Weight = weight;
        }
    }

    // This type of workout has exercises within it (typical workout).
    public class ExercisesWorkout : Workout
    {
        public List<Exercise> Exercises { get; set; }
        public double? RestTime { get; set; }
        public ExercisesWorkout() { } // measured in seconds.
        public ExercisesWorkout(List<Exercise> exercises, double? restTime)
        {
            Exercises = exercises;
            RestTime = restTime;
        }
    }
}
