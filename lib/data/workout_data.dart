import 'package:flutter/material.dart';
import 'package:workout_app/data/hive_database.dart';
import 'package:workout_app/datetime/date_timedata.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/workout_set.dart';

import '../models/tracker.dart';
import '../models/workout.dart';

class WorkoutData extends ChangeNotifier {
  final db = HiveDatabase();

  List<Workout> workoutList = [
    Workout(name: "Upper body", exercises: [
      Exercise(
          name: 'Bench',
          sets: [
            WorkoutSet(
              weight: "100", 
              reps: "10", 
              isCompleted: false
            ),
            WorkoutSet(
              weight: "155", 
              reps: "10", 
              isCompleted: false
            ),
            WorkoutSet(
              weight: "165",
              reps: "10",
              isCompleted: false
            ),
          ],
          isCompleted: false,
        ),
    ]),
    Workout(name: "Lower Body", exercises: [
      Exercise(
          name: 'Deadlift',
          sets: [
            WorkoutSet(
              weight: "200", 
              reps: "10", 
              isCompleted: false
            ),
            WorkoutSet(
              weight: "255", 
              reps: "10", 
              isCompleted: false
            ),
            WorkoutSet(
              weight: "265",
              reps: "10",
              isCompleted: false
            ),
          ],
          isCompleted: false,
        ),
    ]),
  ];

  List<Tracker> trackerList = [
    Tracker(name: 'Push Pull Legs', workouts: [
      Workout(name: "Push", exercises: [
        Exercise(
          name: 'Incline Press', 
          sets: [
            WorkoutSet(
              weight: "100", 
              reps: "10", 
              isCompleted: false
            ),
            WorkoutSet(
              weight: "155", 
              reps: "10", 
              isCompleted: false
            ),
            WorkoutSet(
              weight: "165",
              reps: "10",
              isCompleted: false
            ),
          ],
          isCompleted: false,
        )
      ]),
      Workout(name: "Pull", exercises: [
        Exercise(
          name: 'Barbell row', 
          sets: [
            WorkoutSet(
              weight: "100", 
              reps: "10", 
              isCompleted: false
            ),
            WorkoutSet(
              weight: "155", 
              reps: "10", 
              isCompleted: false
            ),
            WorkoutSet(
              weight: "165",
              reps: "10",
              isCompleted: false
            ),
          ],
          isCompleted: false,
        )
      ])
    ])
  ];

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

  List<Workout> getWorkoutsForDay(DateTime day) {
    //TODO: Stub
    return [workoutList[0]];
  }

  void deleteWorkoutFromDay(DateTime day, String workoutName) {
    //TODO: Stub
  }

  List<Workout> getWorkoutList() {
    return workoutList;
  }

  List<Tracker> getTrackerList() {
    return trackerList;
  }

  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  void addWorkout(String name) {
    Workout newWorkout = Workout(name: name, exercises: []);
    workoutList.add(newWorkout);

    notifyListeners();

    db.saveWorkout(name, newWorkout);
  }

  bool isWorkoutStarted() {
    //TODO: STUB, will need to implement later
    return false;
  }

  void changeWorkoutName(String currentName, String newName) {
    Workout relevantWorkout = getRelevantWorkout(currentName);
    relevantWorkout.name = newName;

    notifyListeners();

    Map<String, Workout> workoutMap = {};
    for (Workout workout in workoutList) {
      workoutMap[workout.name] = workout;
    }
    db.saveWorkouts(workoutMap);
  }

  void deleteWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    List<Workout> workouts = getWorkoutList();
    workouts.remove(relevantWorkout);

    notifyListeners();

    db.deleteWorkout(workoutName);
  }

  void addExercise(String workoutName, String exerciseName, List<WorkoutSet> sets, bool isCompleted) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    relevantWorkout.exercises.add(
        Exercise(name: exerciseName, sets: sets, isCompleted: isCompleted));

    notifyListeners();

    db.saveWorkout(workoutName, relevantWorkout);
  }

  void checkOffExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    Exercise relevantExercise =
        getRelevantExercise(relevantWorkout, exerciseName);
    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();

    db.saveWorkout(workoutName, relevantWorkout);
    int currentAmount = db.getDailyCompletion(todaysDate());
    if (relevantExercise.isCompleted) {
      db.setDailyCompletion(todaysDate(), currentAmount + 1);
    } else {
      db.setDailyCompletion(todaysDate(), currentAmount + currentAmount > 0 ? 0 : - 1);
    }
    loadHeatMap();
  }

  void deleteExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    Exercise relevantExercise =
        getRelevantExercise(relevantWorkout, exerciseName);
    relevantWorkout.exercises.remove(relevantExercise);

    notifyListeners();

    db.saveWorkout(workoutName, relevantWorkout);
  }

  void editExercise(String workoutName, String oldExerciseName,
      String newExerciseName, List<WorkoutSet> newSets) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    Exercise relevantExercise =
        getRelevantExercise(relevantWorkout, oldExerciseName);
    relevantExercise.sets = newSets;  
    notifyListeners();

    db.saveWorkout(workoutName, relevantWorkout);
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
}
