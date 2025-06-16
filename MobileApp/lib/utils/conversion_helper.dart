import 'package:workout_app/models/calorie_tracking.dart';
import 'package:workout_app/models/storage/calorie_tracking.dart' as prefix;
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/storage/exercise.dart' as prefix;
import 'package:workout_app/models/schedule_day.dart';
import 'package:workout_app/models/storage/schedule_day.dart' as prefix;
import 'package:workout_app/models/user_profile.dart';
import 'package:workout_app/models/storage/user_profile.dart' as prefix;
import 'package:workout_app/models/workout_schedule.dart';
import 'package:workout_app/models/storage/workout_schedule.dart' as prefix;
import 'package:workout_app/models/workout_set.dart';
import 'package:workout_app/models/storage/workout_set.dart' as prefix;
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/models/storage/workout.dart' as prefix;

WorkoutSet convertWorkoutSet(prefix.WorkoutSet set) {
  if (set.setType == SetType.time) {
    if (set.duration == null) {
      throw Exception("Set Duration is required");
    }
    if (set.weight == null) {
      throw Exception("Weight is required");
    }
    return TimedSet(
      id: set.id,
      setType: set.setType,
      restTime: set.restTime,
      duration: set.duration!,
      weight: set.weight!,
    );
  }
  if (set.setType == SetType.superSet) {
    if (set.exercises == null) {
      throw Exception("Exercises are required");
    }
    if (set.weights == null) {
      throw Exception("Weights are required");
    }
    if (set.reps == null) {
      throw Exception("Reps are required");
    }
    return SuperSet(
      id: set.id,
      setType: set.setType,
      restTime: set.restTime,
      exercises: set.exercises!,
      weights: set.weights!,
      reps: set.reps!,
    );
  }
  switch (set.setType) {
    case SetType.time:
      if (set.duration == null) {
        throw Exception("Set Duration is required");
      }
      if (set.weight == null) {
        throw Exception("Weight is required");
      }
      return TimedSet(
        id: set.id,
        setType: set.setType,
        restTime: set.restTime,
        duration: set.duration!,
        weight: set.weight!,
      );
    case SetType.superSet:
      if (set.exercises == null) {
        throw Exception("Exercises are required");
      }
      if (set.weights == null) {
        throw Exception("Weights are required");
      }
      if (set.reps == null) {
        throw Exception("Reps are required");
      }
      return SuperSet(
        id: set.id,
        setType: set.setType,
        restTime: set.restTime,
        exercises: set.exercises!,
        weights: set.weights!,
        reps: set.reps!,
      );
    case SetType.dropSet:
      if (set.weights == null) {
        throw Exception("Weights are required");
      }
      if (set.reps == null) {
        throw Exception("Reps are required");
      }
      return DropSet(
        id: set.id,
        setType: set.setType,
        restTime: set.restTime,
        weights: set.weights!,
        reps: set.reps!,
      );
    case SetType.reps:
      if (set.weight == null) {
        throw Exception("Weight is required");
      }
      return WeightedSet(
        id: set.id,
        setType: set.setType,
        restTime: set.restTime,
        weight: set.weight!,
        reps: set.reps![0],
      );
  }
}

prefix.WorkoutSet convertDataWorkoutSet(WorkoutSet set) {
  prefix.WorkoutSet output = prefix.WorkoutSet()
    ..id = set.id
    ..restTime = set.restTime
    ..setType = set.setType;
  if (set is TimedSet) {
    output.duration = set.duration;
    output.weight = set.weight;
  } else if (set is SuperSet) {
    output.exercises = set.exercises;
    output.weights = set.weights;
    output.reps = set.reps;
  } else if (set is DropSet) {
    output.weights = set.weights;
    output.reps = set.reps;
  } else if (set is WeightedSet) {
    output.weight = set.weight;
    output.reps = set.reps != null ? [set.reps!] : null;
  }
  return output;
}

Exercise convertExercise(prefix.Exercise exercise) {
  switch (exercise.exerciseType) {
    case ExerciseType.continual:
      if (exercise.time == null) {
        throw Exception("Exercise time is required");
      }
      return ContinualExercise(
        id: exercise.id,
        name: exercise.name,
        description: exercise.description,
        exerciseType: exercise.exerciseType,
        time: exercise.time!,
        weight: exercise.weight,
      );
    case ExerciseType.sets:
      return SetsExercise(
        id: exercise.id,
        name: exercise.name,
        exerciseType: exercise.exerciseType,
        sets: exercise.workoutSets.map((e) => convertWorkoutSet(e)).toList(),
      );
  }
}

Workout convertWorkout(prefix.Workout workout) {
  return Workout(
    id: workout.id,
    name: workout.name,
    description: workout.description,
    exercises: workout.exercises.map((e) => convertExercise(e)).toList(),
  );
}

ScheduleDay convertScheduleDay(prefix.ScheduleDay scheduleDay) {
  return ScheduleDay(
    id: scheduleDay.id,
    name: scheduleDay.dayName,
    workouts: scheduleDay.workouts.map((e) => convertWorkout(e)).toList(),
    calorieGoal: scheduleDay.calorieGoal,
  );
}

CalorieTracking convertCalorieTracking(prefix.CalorieTracking calorieTracker) {
  return CalorieTracking(
    id: calorieTracker.id,
    workoutDayCalories: calorieTracker.workoutDayCalories,
    restDayCalories: calorieTracker.restDayCalories,
  );
}

UserProfile convertUserProfile(prefix.UserProfile userProfile) {
  return UserProfile(
    id: userProfile.id,
    height: userProfile.height,
    weight: userProfile.weight,
    maintenanceCalories: userProfile.maintenanceCalories,
    lastUpdated: userProfile.lastUpdated,
  );
}

WorkoutSchedule convertWorkoutSchedule(prefix.WorkoutSchedule workoutSchedule) {
  return WorkoutSchedule(
    id: workoutSchedule.id,
    name: workoutSchedule.name,
    description: workoutSchedule.description,
    startDate: workoutSchedule.startDate,
    endDate: workoutSchedule.endDate,
    isActive: workoutSchedule.isActive,
    days: workoutSchedule.days.map((e) => convertScheduleDay(e)).toList(),
    calorieTracking: workoutSchedule.calorieTracking.value != null ? convertCalorieTracking(workoutSchedule.calorieTracking.value!) : null,
  );
}

prefix.Exercise convertDataExercise(Exercise exercise) {
  final output = prefix.Exercise()
    ..id = exercise.id
    ..name = exercise.name
    ..description = exercise.description
    ..exerciseType = exercise.exerciseType;

  if (exercise is SetsExercise) {
    output.workoutSets.addAll(
      exercise.sets.map((e) => convertDataWorkoutSet(e))
    );
  } else if (exercise is ContinualExercise) {
    output.time = exercise.time;
    output.weight = exercise.weight;
  }
  return output;
}

prefix.Workout convertDataWorkout(Workout workout) {
  final output = prefix.Workout()
    ..id = workout.id
    ..name = workout.name
    ..description = workout.description;

  output.exercises.addAll(
    workout.exercises.map((e) => convertDataExercise(e))
  );
  return output;
}

prefix.ScheduleDay convertDataScheduleDay(ScheduleDay scheduleDay) {
  final output = prefix.ScheduleDay()
    ..id = scheduleDay.id
    ..dayName = scheduleDay.name
    ..calorieGoal = scheduleDay.calorieGoal;

  output.workouts.addAll(
    scheduleDay.workouts.map((e) => convertDataWorkout(e))
  );
  return output;
}

prefix.CalorieTracking convertDataCalorieTracking(CalorieTracking calorieTracking) {
  return prefix.CalorieTracking()
    ..id = calorieTracking.id
    ..workoutDayCalories = calorieTracking.workoutDayCalories
    ..restDayCalories = calorieTracking.restDayCalories;
}

prefix.UserProfile convertDataUserProfile(UserProfile userProfile) {
  return prefix.UserProfile()
    ..id = userProfile.id
    ..height = userProfile.height
    ..weight = userProfile.weight
    ..maintenanceCalories = userProfile.maintenanceCalories
    ..lastUpdated = userProfile.lastUpdated;
}

prefix.WorkoutSchedule convertDataWorkoutSchedule(WorkoutSchedule workoutSchedule) {
  final output = prefix.WorkoutSchedule()
    ..id = workoutSchedule.id
    ..name = workoutSchedule.name
    ..description = workoutSchedule.description
    ..startDate = workoutSchedule.startDate
    ..endDate = workoutSchedule.endDate
    ..isActive = workoutSchedule.isActive;

  output.days.addAll(
    workoutSchedule.days.map((e) => convertDataScheduleDay(e))
  );
  if (workoutSchedule.calorieTracking != null) {
    output.calorieTracking.value = convertDataCalorieTracking(workoutSchedule.calorieTracking!);
  }
  return output;
}