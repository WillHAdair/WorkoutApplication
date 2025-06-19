using WorkoutAPI.Models;

namespace WorkoutAPI.TestData
{
    public static class TestData
    {
        public static readonly List<Exercise> exercises =
        [
            new SetsExercise
            {
                ID = 1,
                Name = "Bench Press",
                Sets =
                [
                    new WeightedSet { ID = 1, Weight = 185, Reps = 10 },
                    new WeightedSet { ID = 2, Weight = 195, Reps = 10 },
                    new WeightedSet { ID = 3, Weight = 205 }
                ]
            },
            new SetsExercise
            {
                ID = 2,
                Name = "Overhead Press",
                Sets =
                [
                    new WeightedSet { ID = 4, Weight = 135, Reps = 10 },
                    new WeightedSet { ID = 5, Weight = 145, Reps = 10 },
                    new WeightedSet { ID = 6, Weight = 155, Reps = 8 }
                ]
            },
            new CircuitExercise
            {
                ID = 3,
                Name = "Tricep Circuit",
                RestTime = 30,
                Exercises =
                [
                    new SetsExercise
                    {
                        ID = 1,
                        Name = "Tricep Dips",
                        Sets =
                        [
                            new WeightedSet { ID = 7, Weight = -25, Reps = 10, IsBodyWeight = true },
                            new WeightedSet { ID = 8, Weight = -25, Reps = 10, IsBodyWeight = true },
                            new DropSet
                            {
                                ID = 9,
                                IsBodyWeight = true,
                                WeightRepsMap = new Dictionary<double, int?>
                                {
                                    { -25, 5 },
                                    { -35, 5 },
                                    { -50, null }
                                }
                            }
                        ]
                    },
                    new SetsExercise
                    {
                        ID = 2,
                        Name = "Skull Crushers",
                        Sets =
                        [
                            new TimedSet { ID = 10, Time = 30, Weight = 40 },
                            new TimedSet { ID = 11, Time = 30, Weight = 45 },
                            new TimedSet { ID = 12, Time = 30, Weight = 45 }
                        ]
                    }
                ]
            },
            new SetsExercise
            {
                ID = 4,
                Name = "Deadlift",
                Sets =
                [
                    new WeightedSet { ID = 13, Weight = 225, Reps = 8 },
                    new WeightedSet { ID = 14, Weight = 235, Reps = 8 },
                    new WeightedSet { ID = 15, Weight = 245, Reps = 6 }
                ]
            },
            new SetsExercise
            {
                ID = 5,
                Name = "Pull-Ups",
                Sets =
                [
                    new WeightedSet { ID = 16, Weight = -10, Reps = 8, IsBodyWeight = true },
                    new WeightedSet { ID = 17, Weight = -5, Reps = 8, IsBodyWeight = true },
                    new DropSet
                    {
                        ID = 18,
                        IsBodyWeight = true,
                        WeightRepsMap = new Dictionary<double, int?>
                        {
                            { -10, 5 },
                            { -5, 5 },
                            { 0, null }
                        }
                    }
                ]
            },
            new SetsExercise
            {
                ID = 6,
                Name = "Bicep Curl",
                Sets =
                [
                    new WeightedSet { ID = 19, Weight = 30, Reps = 10 },
                    new WeightedSet { ID = 20, Weight = 35, Reps = 10 },
                    new WeightedSet { ID = 21, Weight = 40, Reps = 8 }
                ]
            },
            new SetsExercise
            {
                ID = 7,
                Name = "Squat",
                Sets =
                [
                    new WeightedSet { ID = 22, Weight = 225, Reps = 8 },
                    new WeightedSet { ID = 23, Weight = 235, Reps = 8 },
                    new WeightedSet { ID = 24, Weight = 245, Reps = 6 }
                ]
            },
            new SetsExercise
            {
                ID = 8,
                Name = "Leg Press",
                Sets =
                [
                    new WeightedSet { ID = 25, Weight = 300, Reps = 10 },
                    new WeightedSet { ID = 26, Weight = 320, Reps = 10 },
                    new WeightedSet { ID = 27, Weight = 340, Reps = 8 }
                ]
            },
            new CircuitExercise
            {
                ID = 4,
                Name = "Calf Circuit",
                RestTime = 30,
                Exercises =
                [
                    new SetsExercise
                    {
                        ID = 3,
                        Name = "Standing Calf Raise",
                        Sets =
                        [
                            new TimedSet { ID = 28, Time = 30, Weight = 100 },
                            new TimedSet { ID = 29, Time = 30, Weight = 110 },
                            new TimedSet { ID = 30, Time = 30, Weight = null }
                        ]
                    },
                    new SetsExercise
                    {
                        ID = 4,
                        Name = "Seated Calf Raise",
                        Sets =
                        [
                            new TimedSet { ID = 31, Time = 30, Weight = null },
                            new TimedSet { ID = 32, Time = 30, Weight = null }
                        ]
                    }
                ]
            }
        ];

        public static readonly List<Workout> workouts =
        [
            new ExercisesWorkout
            {
                ID = 1,
                Name = "Push Day",
                RestTime = 60,
                Exercises = [exercises[0], exercises[1], exercises[2]]
            },
            new ExercisesWorkout
            {
                ID = 2,
                Name = "Pull Day",
                RestTime = 60,
                Exercises = [exercises[3], exercises[4], exercises[5]]
            },
            new ExercisesWorkout
            {
                ID = 3,
                Name = "Leg Day",
                RestTime = 90,
                Exercises = [exercises[6], exercises[7], exercises[8]]
            },
            new TimedWorkout
            {
                ID = 4,
                Name = "Cardio",
                Description = "30 minutes of moderate cardio.",
                Time = 30
            }
        ];

        public static readonly List<ScheduleDay> days =
        [
            new ScheduleDay
            {
                ID = 1,
                Name = "Push Day",
                Description = "Focus on pushing exercises for upper body strength.",
                CalorieGoal = 2500,
                WorkoutTime = new TimeOnly(18, 0),
                Workouts = [workouts[0]]
            },
            new ScheduleDay
            {
                ID = 2,
                Name = "Pull Day",
                Description = "Focus on pulling exercises for upper body strength.",
                CalorieGoal = 2400,
                WorkoutTime = new TimeOnly(18, 30),
                Workouts = [workouts[1]]
            },
            new ScheduleDay
            {
                ID = 3,
                Name = "Leg Day",
                Description = "Focus on lower body strength exercises.",
                CalorieGoal = 2600,
                WorkoutTime = new TimeOnly(19, 0),
                Workouts = [workouts[2], workouts[3]]
            },
            new ScheduleDay
            {
                ID = 4,
                Name = "Rest Day",
                Description = "A day for recovery and rest.",
                CalorieGoal = null,
                Workouts = []
            }
        ];

        public static readonly List<WorkoutSchedule> schedules =
        [
            new WorkoutSchedule
            {
                ID = 1,
                Name = "Push Pull Legs",
                Description = "A classic workout split focusing on push, pull, and leg exercises.",
                StartDate = DateTime.Now.AddDays(-10),
                EndDate = DateTime.Now.AddDays(20),
                Days = days
            }
        ];

        public static readonly UserProfile profile = new()
        {
            UserName = "WillhAdair",
            Height = 70.0,
            Weight = 196.5,
            Schedules = schedules
        };
    }
}
