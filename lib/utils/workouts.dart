import 'package:flutter/material.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/workout_set.dart';
import 'package:workout_app/models/schedule_day.dart';
import 'package:workout_app/utils/database_helper.dart';

class WorkoutsProvider extends ChangeNotifier {
  /// Get a workout by its ID
  Future<Workout?> getWorkoutById(int id) async {
    return await DatabaseHelper.getById<Workout>(id);
  }

  Future<void> addWorkout(Workout workout) async {
    await DatabaseHelper.add(workout);
    notifyListeners();
  }

  Future<void> addExercise(Exercise exercise) async {
    await DatabaseHelper.add(exercise);
    notifyListeners();
  }

  Future<void> addWorkoutSet(WorkoutSet workoutSet) async {
    await DatabaseHelper.add(workoutSet);
    notifyListeners();
  }

  Future<List<Workout>> getAllWorkouts() async {
    return await DatabaseHelper.getAll<Workout>();
  }

  Future<List<Exercise>> getAllExercises() async {
    return await DatabaseHelper.getAll<Exercise>();
  }

  Future<List<WorkoutSet>> getAllWorkoutSets() async {
    return await DatabaseHelper.getAll<WorkoutSet>();
  }

  Future<List<Workout>> getWorkoutsByDay(int scheduleDayId) async {
    final scheduleDay = await DatabaseHelper.getById<ScheduleDay>(scheduleDayId);
    if (scheduleDay != null) {
      return scheduleDay.workouts.toList();
    }
    return [];
  }

  Future<void> updateWorkout(Workout workout) async {
    await DatabaseHelper.update(workout);
    notifyListeners();
  }

  Future<void> updateExercise(Exercise exercise) async {
    await DatabaseHelper.update(exercise);

    notifyListeners();    notifyListeners();
  }

  Future<void> updateWorkoutSet(WorkoutSet workoutSet) async {
    await DatabaseHelper.update(workoutSet);
    notifyListeners();
  }

  Future<void> deleteWorkoutById(int id) async {
    await DatabaseHelper.deleteById<Workout>(id);
    notifyListeners();
  }

  Future<void> deleteExerciseById(int id) async {
    await DatabaseHelper.deleteById<Exercise>(id);
    notifyListeners();
  }

  Future<void> deleteWorkoutSetById(int id) async {
    await DatabaseHelper.deleteById<WorkoutSet>(id);
    notifyListeners();
  }
}