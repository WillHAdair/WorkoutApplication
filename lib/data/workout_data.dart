import 'package:flutter/material.dart';
import 'package:workout_app/data/hive_database.dart';
import 'package:workout_app/datetime/date_timedata.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/workout_set.dart';

import '../models/workout.dart';

class WorkoutData extends ChangeNotifier {
  String getStartDate() {
    return db.getStartDate();
  }

  Map<DateTime, int> heatMapDataSet = {};
  final db = HiveDatabase();

  List<Workout> workoutList = [
    Workout(name: "Upper body", exercises: [
      Exercise(
        name: 'Bench',
        sets: [
          WorkoutSet(weight: "100", reps: "10", isCompleted: false),
          WorkoutSet(weight: "155", reps: "10", isCompleted: false),
          WorkoutSet(weight: "165", reps: "10", isCompleted: false),
        ],
        isCompleted: false,
      ),
    ]),
    Workout(name: "Lower Body", exercises: [
      Exercise(
        name: 'Deadlift',
        sets: [
          WorkoutSet(weight: "200", reps: "10", isCompleted: false),
          WorkoutSet(weight: "255", reps: "10", isCompleted: false),
          WorkoutSet(weight: "265", reps: "10", isCompleted: false),
        ],
        isCompleted: false,
      ),
    ]),
    Workout(name: "Push", exercises: [
      Exercise(
        name: 'Incline Press',
        sets: [
          WorkoutSet(weight: "100", reps: "10", isCompleted: false),
          WorkoutSet(weight: "155", reps: "10", isCompleted: false),
          WorkoutSet(weight: "165", reps: "10", isCompleted: false),
        ],
        isCompleted: false,
      )
    ]),
    Workout(name: "Pull", exercises: [
      Exercise(
        name: 'Barbell row',
        sets: [
          WorkoutSet(weight: "100", reps: "10", isCompleted: false),
          WorkoutSet(weight: "155", reps: "10", isCompleted: false),
          WorkoutSet(weight: "165", reps: "10", isCompleted: false),
        ],
        isCompleted: false,
      )
    ]),
    Workout(name: "break", exercises: []),
  ];

  // Initialization
  void initializeWorkoutList() {
    if (db.workoutBox.isNotEmpty) {
      workoutList = db.readAllWorkouts();
    } else {
      Map<String, Workout> workoutMap = {};
      for (Workout workout in workoutList) {
        workoutMap[workout.name] = workout;
      }
      db.saveWorkouts(workoutMap);
    }

    loadHeatMap();
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(getStartDate());

    int daysBetween = DateTime.now().difference(startDate).inDays;

    for (int i = 0; i < daysBetween + 1; i++) {
      String date = convertDateTimeToString(startDate.add(Duration(days: i)));
      int completionStatus = db.getDailyCompletion(date);

      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): completionStatus
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
    }
  }

  // Workouts
  // Get Workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  Workout getTodaysWorkout() {
    return workoutList[0];
  }

  Workout? getStartedWorkout() {
    return db.getStartedWorkout();
  }

  List<Workout> getFilledWorkouts() {
    List<Workout> workouts = [];
    for (Workout workout in getWorkoutList()) {
      if (workout.exercises.isNotEmpty) {
        workouts.add(workout);
      }
    }
    return workouts;
  }

  Workout? getRelevantWorkout(String workoutName) {
    try {
      return workoutList.firstWhere((workout) => workout.name == workoutName);
    } catch (e) {
      return null;
    }
  }

  // Add Workouts
  void addWorkout(String name) {
    Workout newWorkout = Workout(name: name, exercises: []);
    workoutList.add(newWorkout);

    notifyListeners();

    db.saveWorkout(name, newWorkout);
  }

  void startWorkout(Workout workout) {
    db.saveWorkout(keyMap[Keys.startedWorkout].toString(), workout);
  }

  // Edit/Delete Workouts
  void changeWorkoutName(String currentName, String newName) {
    Workout relevantWorkout = getRelevantWorkout(currentName)!;
    relevantWorkout.name = newName;

    notifyListeners();

    Map<String, Workout> workoutMap = {};
    for (Workout workout in workoutList) {
      workoutMap[workout.name] = workout;
    }
    db.saveWorkouts(workoutMap);
  }

  void deleteWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName)!;
    List<Workout> workouts = getWorkoutList();
    workouts.remove(relevantWorkout);

    notifyListeners();

    db.deleteWorkout(workoutName);
  }
  // Exercises

  // Get Exercises
  Exercise getRelevantExercise(Workout workout, String exerciseName) {
    return workout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);
  }

  Exercise getFirstUnchecked(Workout workout) {
    if (workout.exercises.isNotEmpty) {
      for (Exercise exercise in workout.exercises) {
        if (!exercise.isCompleted) {
          return exercise;
        }
      }
    }
    return standIn;
  }

  List<Exercise> getUncheckedExercises(Workout workout) {
    List<Exercise> exercises = [];
    bool first = false;
    for (Exercise exercise in workout.exercises) {
      if (!exercise.isCompleted && first) {
        exercises.add(exercise);
      } else if (!exercise.isCompleted) {
        first = true;
      }
    }
    return exercises;
  }

  List<Exercise> getCheckedExercises(Workout workout) {
    List<Exercise> exercises = [];
    for (Exercise exercise in workout.exercises) {
      if (exercise.isCompleted) {
        exercises.add(exercise);
      }
    }
    return exercises;
  }

  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName)!;
    return relevantWorkout.exercises.length;
  }

  // Add Exercises
  void addExercise(String workoutName, String exerciseName,
      List<WorkoutSet> sets, bool isCompleted) {
    Workout relevantWorkout = getRelevantWorkout(workoutName)!;
    relevantWorkout.exercises.add(
        Exercise(name: exerciseName, sets: sets, isCompleted: isCompleted));

    notifyListeners();

    db.saveWorkout(workoutName, relevantWorkout);
  }

  // Edit/Delete Exercises
  void checkOffExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName)!;
    Exercise relevantExercise =
        getRelevantExercise(relevantWorkout, exerciseName);
    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();

    db.saveWorkout(workoutName, relevantWorkout);
    int currentAmount = db.getDailyCompletion(todaysDate());
    if (relevantExercise.isCompleted) {
      db.setDailyCompletion(todaysDate(), currentAmount + 1);
    } else {
      db.setDailyCompletion(
          todaysDate(), currentAmount + currentAmount > 0 ? 0 : -1);
    }
    loadHeatMap();
  }

  void deleteExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName)!;
    Exercise relevantExercise =
        getRelevantExercise(relevantWorkout, exerciseName);
    relevantWorkout.exercises.remove(relevantExercise);

    notifyListeners();

    db.saveWorkout(workoutName, relevantWorkout);
  }

  void editExerciseName(Workout workout, Exercise exercise, String newName) {
    exercise.name = newName;
    notifyListeners();
    db.saveWorkout(workout.name, workout);
  }

  /// Sets

  // Get Sets
  int getSetNumber(Workout workout, Exercise exercise) {
    return workout.exercises[workout.exercises.indexOf(exercise)].sets.length;
  }

  WorkoutSet getRelevantSet(Exercise exercise, int index) {
    return exercise.sets[index];
  }

  // Add Sets
  void addSet(Exercise exercise, String weight, String reps) {
    exercise.sets
        .add(WorkoutSet(reps: reps, weight: weight, isCompleted: false));

    notifyListeners();
  }

  // Edit/Delete Sets
  void editSet(Exercise exercise, int index, String? weight, String? reps) {
    if (weight != null) {
      exercise.sets[index].weight = weight;
    }
    if (reps != null) {
      exercise.sets[index].reps = reps;
    }

    notifyListeners();
  }

  void deleteSet(Exercise exercise, int index) {
    exercise.sets.removeAt(index);

    notifyListeners();
  }

  // Workout History

  bool isWorkoutStarted() {
    return db.checkWorkoutStarted();
  }

  void changeWorkoutStarted(bool status) {
    db.changeWorkoutStarted(status);
    notifyListeners();
  }
}
