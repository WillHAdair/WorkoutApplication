import 'package:flutter/material.dart';
import 'package:workout_app/data/hive_database.dart';
import 'package:workout_app/datetime/date_timedata.dart';
import 'package:workout_app/models/exercise.dart';

import '../models/workout.dart';

class WorkoutData extends ChangeNotifier {
  final db = HiveDatabase();

  List<Workout> workoutList = [
    Workout(name: "Upper body", exercises: [
      Exercise(
          name: 'Bench',
          weight: '185',
          reps: '1',
          sets: '4',
          isCompleted: false)
    ]),
    Workout(name: "Lower Body", exercises: [
      Exercise(
          name: 'Deadlift',
          weight: '205',
          reps: '1',
          sets: '3',
          isCompleted: false)
    ]),
  ];

  void initializeWorkoutList() {
    if (db.selectedKeyFound("WORKOUTS") & db.selectedKeyFound("EXERCISES")) {
      workoutList = db.readWorkouts();
    } else {
      db.saveWorkouts(workoutList);
    }

    loadHeatMap();
  }

  List<Workout> getWorkoutList() {
    return workoutList;
  }

  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));

    notifyListeners();

    db.saveWorkouts(workoutList);
  }

  void changeWorkoutName(String currentName, String newName) {
    Workout relevantWorkout = getRelevantWorkout(currentName);
    relevantWorkout.name = newName;

    notifyListeners();

    db.saveWorkouts(workoutList);
  }

  void deleteWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    List<Workout> workouts = getWorkoutList();
    workouts.remove(relevantWorkout);

    notifyListeners();

    db.saveWorkouts(workoutList);
  }

  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    relevantWorkout.exercises.add(
        Exercise(name: exerciseName, weight: weight, reps: reps, sets: sets));

    notifyListeners();

    db.saveWorkouts(workoutList);
  }

  void checkOffExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    Exercise relevantExercise =
        getRelevantExercise(relevantWorkout, exerciseName);
    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();

    db.saveWorkouts(workoutList);

    loadHeatMap();
  }

  void deleteExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    Exercise relevantExercise =
        getRelevantExercise(relevantWorkout, exerciseName);
    relevantWorkout.exercises.remove(relevantExercise);

    notifyListeners();

    db.saveWorkouts(workoutList);
  }

  void editExercise(String workoutName, String oldExerciseName,
      String newExerciseName, String weight, String reps, String sets) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    Exercise relevantExercise =
        getRelevantExercise(relevantWorkout, oldExerciseName);
    relevantExercise.name = newExerciseName;
    relevantExercise.weight = weight;
    relevantExercise.sets = sets;
    relevantExercise.reps = reps;
    notifyListeners();

    db.saveWorkouts(workoutList);
  }

  Workout getRelevantWorkout(String workoutName) {
    return workoutList.firstWhere((workout) => workout.name == workoutName);
  }

  Exercise getRelevantExercise(Workout workout, String exerciseName) {
    return workout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);
  }

  String getStartDate() {
    return db.getStartDate();
  }

  Map<DateTime, int> heatMapDataSet = {};

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(getStartDate());

    int daysBetween = DateTime.now().difference(startDate).inDays;

    for (int i = 0; i < daysBetween + 1; i++) {
      String date = convertDateTimeToString(startDate.add(Duration(days: i)));
      int completionStatus = db.getCompletionStatus(date);

      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): completionStatus
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
    }
  }
}
