namespace WorkoutAPI.Models
{
    public abstract class Exercise
    {
        public int ID { get; set; }
        public required string Name { get; set; }
        public string? Description { get; set; }
        public double? RestTime { get; set; } // measured in seconds.
    }

    // This type of exercise just has a timer
    public class TimedExercise : Exercise
    {
        public double Time { get; set; }
        public double? Weight { get; set; }
        public TimedExercise() { }
        public TimedExercise(int id, string name, string description, double? restTime, double time, double? weight)
        {
            ID = id;
            Name = name;
            Description = description;
            RestTime = restTime;
            Weight = weight;
            Time = time;
            Weight = weight;
        }
    }

    // This type of exercise has Workout Sets
    public class SetsExercise : Exercise
    {
        public List<WorkoutSet> Sets { get; set; }
        public SetsExercise() { }
        public SetsExercise(int id, string name, string description, List<WorkoutSet> sets, double? restTime)
        {
            ID = id;
            Name = name;
            Description = description;
            Sets = sets;
            RestTime = restTime;
        }
    }

    // This exercise contains a list of exercises that are performed in a circuit
    public class CircuitExercise : Exercise
    {
        public List<Exercise> Exercises { get; set; }
        public CircuitExercise() { }
        public CircuitExercise(int id, string name, string description, List<Exercise> exercises, double? restTime)
        {
            ID = id;
            Name = name;
            Description = description;
            Exercises = exercises;
            RestTime = restTime;
        }
    }
}
