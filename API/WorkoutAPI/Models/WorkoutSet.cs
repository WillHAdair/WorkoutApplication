namespace WorkoutAPI.Models
{
    public abstract class WorkoutSet
    {
        public int ID { get; set; }
        public required string Name { get; set; }
        public required string Description { get; set; }
        public double? RestTime { get; set; }
    }

    // This type of set just involves a time and optional weight
    public class TimedSet : WorkoutSet
    {
        public double Time { get; set; }
        public double? Weight { get; set; }
        public TimedSet() { }
        public TimedSet(int id, string name, string description, double? restTime, double time, double? weight)
        {
            ID = id;
            Name = name;
            Description = description;
            RestTime = restTime;
            Time = time;
            Weight = weight;
        }
    }

    public class WeightedSet : WorkoutSet
    {
        public double Weight { get; set; }
        public int? Reps { get; set; } // Null indicates to failure
        public WeightedSet() { }
        public WeightedSet(int id, string name, string description, double? restTime, double weight, int? reps)
        {
            ID = id;
            Name = name;
            Description = description;
            RestTime = restTime;
            Weight = weight;
            Reps = reps;
        }
    }

    public class DropSet : WorkoutSet
    {
        public List<double> Weight { get; set; }
        public List<int?> Reps { get; set; } // Null indicates to failure
        public DropSet() { }
        public DropSet(int id, string name, string description, double? restTime, List<double> weight, List<int?> reps)
        {
            ID = id;
            Name = name;
            Description = description;
            RestTime = restTime;
            Weight = weight;
            Reps = reps;
        }
    }
}
