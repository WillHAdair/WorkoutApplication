import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:workout_app/datetime/date_timedata.dart';
import 'package:workout_app/models/exercise.dart';

import '../models/workout.dart';

class HiveDatabase {
  final _myBox = Hive.box("workout_database");

  bool previousDataExists() {
    if (_myBox.isEmpty) {
      if (kDebugMode) {
        print("previous data not here");
      }
      _myBox.put("START_DATE", todaysDate());
      return false;
    } else {
      if (kDebugMode) {
        print("previous data is here");
      }
      return true;
    }
  }

  String getStartDate() {
    return _myBox.get("START_DATE");
  }

  void saveToDatabase(List<Workout> workouts) {
    final List<String> workoutList = convertObjectToWorkoutList(workouts);
    final List<List<List<String>>> exerciseList = convertObjectToExerciseList(workouts);

    _myBox.put("COMPLETION_STATUS_${todaysDate()}", getCompletedExercises(workouts));

    _myBox.put("WORKOUTS", workoutList);
    _myBox.put("EXERCISES", exerciseList);
  }

  List<Workout> readFromDatabase() {
    List<Workout> mySavedWorkouts = [];

    List<String> workoutNames = _myBox.get("WORKOUTS");
    final exerciseDetails = _myBox.get("EXERCISES");

    for (int i=0; i<workoutNames.length; i++) {
      List<Exercise> exercisesPerWorkout = [];

      for (int j=0; j<exerciseDetails[i].length; j++) {
        exercisesPerWorkout.add(Exercise(
          name: exerciseDetails[i][j][0], 
          weight: exerciseDetails[i][j][1], 
          reps: exerciseDetails[i][j][2], 
          sets: exerciseDetails[i][j][3],
          isCompleted: exerciseDetails[i][j][4] == "true" ? true : false,
          )
        );
      }

      Workout workout = Workout(name: workoutNames[i], exercises: exercisesPerWorkout);

      mySavedWorkouts.add(workout);
    }
    return mySavedWorkouts;
  }

  int getCompletedExercises(List<Workout> workouts) {
    int completedExercies = 0;
    for (Workout workout in workouts) {
      for (Exercise exercise in workout.exercises) {
        if (exercise.isCompleted) {
          completedExercies++;
        }
      }
    }
    return completedExercies;
  }

  int getCompletionStatus(String date) {
    return _myBox.get("COMPLETION_STATUS_$date") ?? 0;
  }
}

List<String> convertObjectToWorkoutList(List<Workout> workouts) {

  List<String> workoutList = [];

  for (Workout workout in workouts) {
    workoutList.add(workout.name);
  }

  return workoutList;
}

List<List<List<String>>> convertObjectToExerciseList(List<Workout> workouts) {
  List<List<List<String>>> exerciseList = [];

  for (Workout workout in workouts) {
    List<Exercise> exercisesInWorkout = workout.exercises;
    List<List<String>> individualWorkout = [];

    for (Exercise exercise in exercisesInWorkout) {
      List<String> individualExercise = [];

      individualExercise.addAll(
        [
          exercise.name,
          exercise.weight,
          exercise.reps,
          exercise.sets,
          exercise.isCompleted.toString(),
        ]
      );
      individualWorkout.add(individualExercise);
    }

    exerciseList.add(individualWorkout);
  }

  return exerciseList;
}