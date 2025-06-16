namespace WorkoutAPI.Models
{
    public abstract class Exercise
    {
        public int ID { get; set; }
        public required string Name { get; set; }
        public required string Description { get; set; }
    }

    // This type of exercise just has a timer
    public class TimedExercise : Exercise
    {
        public double Time { get; set; }
        public double? Weight { get; set; }
        public TimedExercise() { }
        public TimedExercise(int id, string name, string description, double time, double? weight)
        {
            ID = id;
            Name = name;
            Description = description;
            Weight = weight;
            Time = time;
            Weight = weight;
        }
    }

    // This type of exercise has Workout Sets
    public class SetsExercise : Exercise
    {
        public List<int> SuperSetIDs { get; set; }
        public List<WorkoutSet> Sets { get; set; }
        public double? RestTime { get; set; }
        public SetsExercise() { }
        public SetsExercise(int id, string name, string description, List<int> superSetIDs, List<WorkoutSet> sets, double? restTime)
        {
            ID = id;
            Name = name;
            Description = description;
            SuperSetIDs = superSetIDs;
            Sets = sets;
            RestTime = restTime;
        }
    }
}
