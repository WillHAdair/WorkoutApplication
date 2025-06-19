namespace WorkoutAPI.Models
{
    public abstract class WorkoutSet
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public double? RestTime { get; set; }
        public bool IsBodyWeight { get; set; } = false; // Indicates if this set is bodyweight or not
    }

    // This type of set just involves a time and optional weight
    public class TimedSet : WorkoutSet
    {
        public double Time { get; set; }
        public double? Weight { get; set; }
        public TimedSet() { }
        public TimedSet(int id, string name, string description, double? restTime, bool isBodyWeight, double time, double? weight)
        {
            ID = id;
            Name = name;
            Description = description;
            RestTime = restTime;
            IsBodyWeight = isBodyWeight;
            Time = time;
            Weight = weight;
        }
    }

    public class WeightedSet : WorkoutSet
    {
        public double Weight { get; set; }
        public int? Reps { get; set; } // Null indicates to failure
        public WeightedSet() { }
        public WeightedSet(int id, string name, string description, double? restTime, bool isBodyWeight, double weight, int? reps)
        {
            ID = id;
            Name = name;
            Description = description;
            RestTime = restTime;
            IsBodyWeight = isBodyWeight;
            Weight = weight;
            Reps = reps;
        }
    }

    public class DropSet : WorkoutSet
    {
        public Dictionary<double, int?> WeightRepsMap { get; set; }
        public DropSet() { }
        public DropSet(int id, string name, string description, double? restTime, bool isBodyWeight, Dictionary<double, int?> weightRepsMap)
        {
            ID = id;
            Name = name;
            Description = description;
            RestTime = restTime;
            IsBodyWeight = isBodyWeight;
            WeightRepsMap = weightRepsMap;
        }
    }
}
