import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workout_app/models/past_schedule_day.dart';
import 'package:workout_app/models/storage/past_schedule_day.dart' as prefix;
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
  switch (set.setType) {
    case WorkoutSetType.timed:
      if (set.duration == null) {
        throw Exception("Set Duration is required");
      }
      if (set.weight == null) {
        throw Exception("Weight is required");
      }
      return TimedSet(
        id: set.id,
        description: set.description,
        restTime: set.restTime,
        duration: set.duration!,
        weight: set.weight!,
        isBodyWeight: set.isBodyWeight,
      );
    case WorkoutSetType.dropset:
      if (set.weightList == null) {
        throw Exception("Weights are required");
      }
      if (set.repsList == null) {
        throw Exception("Reps are required");
      }
      return DropSet(
        id: set.id,
        description: set.description,
        restTime: set.restTime,
        isBodyWeight: set.isBodyWeight,
        weightRepsMap: Map.fromIterables(set.weightList!, set.repsList!),
      );
    case WorkoutSetType.reps:
      if (set.weight == null) {
        throw Exception("Weight is required");
      }
      return RepsSet(
        id: set.id,
        description: set.description,
        isBodyWeight: set.isBodyWeight,
        restTime: set.restTime,
        weight: set.weight!,
        reps: set.reps,
      );
  }
}

prefix.WorkoutSet convertDataWorkoutSet(WorkoutSet set) {
  prefix.WorkoutSet output =
      prefix.WorkoutSet()
        ..id = set.id
        ..description = set.description
        ..isBodyWeight = set.isBodyWeight
        ..restTime = set.restTime;
  if (set is TimedSet) {
    output.duration = set.duration;
    output.weight = set.weight;
    output.setType = WorkoutSetType.timed;
  } else if (set is DropSet) {
    output.weightList = set.weightRepsMap.keys.toList();
    output.repsList = set.weightRepsMap.values.toList();
    output.setType = WorkoutSetType.dropset;
  } else if (set is RepsSet) {
    output.weight = set.weight;
    output.reps = set.reps;
    output.setType = WorkoutSetType.reps;
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
        time: exercise.time!,
        weight: exercise.weight,
        restTime: exercise.restTime,
      );
    case ExerciseType.sets:
      return SetsExercise(
        id: exercise.id,
        name: exercise.name,
        description: exercise.description,
        sets: exercise.workoutSets.map((e) => convertWorkoutSet(e)).toList(),
        restTime: exercise.restTime,
      );
    case ExerciseType.circuit:
      return CircuitExercise(
        id: exercise.id,
        name: exercise.name,
        description: exercise.description,
        exercises: exercise.exercises.map((e) => convertExercise(e)).toList(),
        restTime: exercise.restTime,
      );
  }
}

Workout convertWorkout(prefix.Workout workout) {
  switch (workout.workoutType) {
    case WorkoutType.timed:
      if (workout.duration == null) {
        throw Exception("Workout duration is required");
      }
      return TimedWorkout(
        id: workout.id,
        name: workout.name,
        description: workout.description,
        duration: workout.duration!,
        weight: workout.weight,
      );
    case WorkoutType.exercises:
      return ExercisesWorkout(
        id: workout.id,
        name: workout.name,
        description: workout.description,
        exercises: workout.exercises.map((e) => convertExercise(e)).toList(),
        restTime: workout.restTime,
      );
  }
}

ScheduleDay convertScheduleDay(prefix.ScheduleDay scheduleDay) {
  DateTime? startTime =
      scheduleDay.startTime != null
          ? DateFormat("h:mm a").parse(scheduleDay.startTime!)
          : null;
  return ScheduleDay(
    id: scheduleDay.id,
    name: scheduleDay.name,
    description: scheduleDay.description,
    startTime: startTime != null ? TimeOfDay.fromDateTime(startTime) : null,
    workouts: scheduleDay.workouts.map((e) => convertWorkout(e)).toList(),
    calorieGoal: scheduleDay.calorieGoal,
  );
}

PastScheduleDay convertPastScheduleDay(prefix.PastScheduleDay pastScheduleDay) {
  Map<Workout, double>? workoutCompletionMap;
  final workoutList =
      pastScheduleDay.workouts.toList().map((e) => convertWorkout(e)).toList();
  final percentages = pastScheduleDay.completionPercentages;
  if (percentages != null && workoutList.length == percentages.length) {
    workoutCompletionMap = {
      for (int i = 0; i < workoutList.length; i++)
        workoutList[i]: percentages[i],
    };
  }
  DateTime? startTime =
      pastScheduleDay.startTime != null
          ? DateFormat("h:mm a").parse(pastScheduleDay.startTime!)
          : null;
  DateTime? endTime =
      pastScheduleDay.endTime != null
          ? DateFormat("h:mm a").parse(pastScheduleDay.endTime!)
          : null;

  return PastScheduleDay(
    id: pastScheduleDay.id,
    scheduleID: pastScheduleDay.schedule.value?.id ?? 0,
    workoutCompletionMap: workoutCompletionMap,
    day: pastScheduleDay.day,
    startTime: startTime != null ? TimeOfDay.fromDateTime(startTime) : null,
    endTime: endTime != null ? TimeOfDay.fromDateTime(endTime) : null,
    caloriesGoal: pastScheduleDay.caloriesGoal,
    caloriesBurned: pastScheduleDay.caloriesBurned,
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
  );
}

UserProfile convertUserProfile(prefix.UserProfile userProfile) {
  return UserProfile(
    id: userProfile.id,
    userName: userProfile.userName,
    height: userProfile.height,
    weight: userProfile.weight,
    maintenanceCalories: userProfile.maintenanceCalories,
    pastScheduleDays:
        userProfile.pastScheduleDays
            .map((e) => convertPastScheduleDay(e))
            .toList(),
    schedules:
        userProfile.schedules.map((e) => convertWorkoutSchedule(e)).toList(),
    lastUpdated: userProfile.lastUpdated,
  );
}

prefix.Exercise convertDataExercise(Exercise exercise) {
  final output =
      prefix.Exercise()
        ..id = exercise.id
        ..name = exercise.name
        ..description = exercise.description
        ..restTime = exercise.restTime;

  if (exercise is CircuitExercise) {
    output.exerciseType = ExerciseType.circuit;
    output.exercises.addAll(
      exercise.exercises.map((e) => convertDataExercise(e)),
    );
  } else if (exercise is SetsExercise) {
    output.exerciseType = ExerciseType.sets;
    output.workoutSets.addAll(
      exercise.sets.map((e) => convertDataWorkoutSet(e)),
    );
  } else if (exercise is ContinualExercise) {
    output.exerciseType = ExerciseType.continual;
    output.time = exercise.time;
    output.weight = exercise.weight;
  }
  return output;
}

prefix.Workout convertDataWorkout(Workout workout) {
  final output =
      prefix.Workout()
        ..id = workout.id
        ..name = workout.name
        ..description = workout.description;

  if (workout is TimedWorkout) {
    output.workoutType = WorkoutType.timed;
    output.duration = workout.duration;
    output.weight = workout.weight;
  } else if (workout is ExercisesWorkout) {
    output.workoutType = WorkoutType.exercises;
    output.exercises.addAll(
      workout.exercises.map((e) => convertDataExercise(e)),
    );
    output.restTime = workout.restTime;
  }
  return output;
}

prefix.ScheduleDay convertDataScheduleDay(ScheduleDay scheduleDay) {
  final output =
      prefix.ScheduleDay()
        ..id = scheduleDay.id
        ..name = scheduleDay.name
        ..description = scheduleDay.description
        ..calorieGoal = scheduleDay.calorieGoal;
  if (scheduleDay.startTime != null) {
    output.startTime = DateFormat("h:mm a").format(
      DateTime(0, 0, 0, scheduleDay.startTime!.hour, scheduleDay.startTime!.minute),
    );
  }

  output.workouts.addAll(
    scheduleDay.workouts.map((e) => convertDataWorkout(e)),
  );
  return output;
}

prefix.PastScheduleDay convertDataPastScheduleDay(PastScheduleDay pastScheduleDay) {
  return prefix.PastScheduleDay()
    ..id = pastScheduleDay.id
    ..day = pastScheduleDay.day
    ..caloriesGoal = pastScheduleDay.caloriesGoal
    ..caloriesBurned = pastScheduleDay.caloriesBurned
    ..startTime = pastScheduleDay.startTime != null
        ? DateFormat("h:mm a").format(
            DateTime(0, 0, 0, pastScheduleDay.startTime!.hour, pastScheduleDay.startTime!.minute),
          )
        : null
    ..endTime = pastScheduleDay.endTime != null
        ? DateFormat("h:mm a").format(
            DateTime(0, 0, 0, pastScheduleDay.endTime!.hour, pastScheduleDay.endTime!.minute),
          )
        : null
      ..workouts.addAll(
        pastScheduleDay.workoutCompletionMap?.keys
            .map((e) => convertDataWorkout(e)) ??
            [],
      )
      ..completionPercentages = pastScheduleDay.workoutCompletionMap?.values.toList() ?? [];
}

prefix.UserProfile convertDataUserProfile(UserProfile userProfile) {
  return prefix.UserProfile()
    ..id = userProfile.id
    ..userName = userProfile.userName
    ..height = userProfile.height
    ..weight = userProfile.weight
    ..maintenanceCalories = userProfile.maintenanceCalories
    ..lastUpdated = userProfile.lastUpdated
    ..pastScheduleDays.addAll(
      userProfile.pastScheduleDays.map((e) => convertDataPastScheduleDay(e)),
    )
    ..schedules.addAll(
      userProfile.schedules.map((e) => convertDataWorkoutSchedule(e)),
    );
}

prefix.WorkoutSchedule convertDataWorkoutSchedule(WorkoutSchedule workoutSchedule) {
  final output =
      prefix.WorkoutSchedule()
        ..id = workoutSchedule.id
        ..name = workoutSchedule.name
        ..description = workoutSchedule.description
        ..startDate = workoutSchedule.startDate
        ..endDate = workoutSchedule.endDate
        ..isActive = workoutSchedule.isActive;

  output.days.addAll(
    workoutSchedule.days.map((e) => convertDataScheduleDay(e)),
  );
  return output;
}
