import 'package:flutter/material.dart';
import 'package:workout_app/data/hive_database.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/datetime/date_timedata.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/schedule.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/models/workout_set.dart';

class ScheduleData extends ChangeNotifier {
  
  final db = HiveDatabase();
  List<Schedule> scheduleList = [
    Schedule(name: 'Push Pull Legs', period: 2, workouts: [
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

  // Initialization
  void initializeScheduleList() {
    if (db.scheduleBox.isNotEmpty) {
      scheduleList = db.readSchedules();
    } else {
      Map<String, Schedule> scheduleMap = {};
      for (Schedule schedule in scheduleList) {
        scheduleMap[schedule.name] = schedule;
      }
      db.saveSchedules(scheduleMap);
    }
  }

  // Get Schedules
  List<Schedule> getSchedules() {
    return scheduleList;
  }

  Schedule getRelevantSchedule(String scheduleName) {
    return scheduleList.firstWhere((element) => element.name == scheduleName);
  }

  Schedule? getCurrentSchedule() {
    return db.getCurrentSchedule();
  }

  // Add Schedules
  void addSchedule(String scheduleName) {
    Schedule newSchedule = Schedule(name: scheduleName, period: 0, workouts: []);
    scheduleList.add(newSchedule);

    notifyListeners();
  }

  void addWorkoutsToDay(DateTime day, List<Workout> workouts) {
    db.addWorkoutsToDay(convertDateTimeToString(day), workouts.map((workout) => workout.name).toList());
    notifyListeners();
  }

  // Edit/Delete Schedules
  void editChosenSchedule(Schedule schedule) {
    db.saveSchedule(keyMap[Keys.currentSchedule].toString(), schedule);
    notifyListeners();
  }

  void changeScheduleName(String currentName, String newName) {
    Schedule relevantSchedule = getRelevantSchedule(currentName);
    relevantSchedule.name = newName;

    notifyListeners();
    db.deleteSchedule(currentName);
    db.saveSchedule(newName, relevantSchedule);
  }

  void editSchedule(String name, int period, List<Workout> workouts, bool? isCCurrent) {
    Schedule schedule = getRelevantSchedule(name);
    schedule.period = period;
    schedule.workouts = workouts;
    schedule.isCurrent = isCCurrent;

    notifyListeners();
  }

  void deleteSchedule(String scheduleName) {
    Schedule relevantSchedule = getRelevantSchedule(scheduleName);
    scheduleList.remove(relevantSchedule);

    notifyListeners();
    db.deleteSchedule(scheduleName);
  }

  void deleteChosenSchedule() {
    db.deleteSchedule(keyMap[Keys.currentSchedule].toString());
    notifyListeners();
  }

  List<Workout> getWorkoutsForDay(DateTime day) {
    List<Workout> dailyWorkouts = [];
    List<String> workoutNames = db.getWorkoutsForDay(convertDateTimeToString(day));
    if (workoutNames.isEmpty) {
      // TODO: remove when schedule is made
    return [WorkoutData().getWorkoutList()[0]];
    }
    for (String workout in workoutNames) {
      Workout? w = WorkoutData().getRelevantWorkout(workout);
      if (w != null) {
        dailyWorkouts.add(w);
      }
    }
    return dailyWorkouts;
  }

  void deleteWorkoutFromDay(DateTime day, String workoutName) {
    db.deleteWorkoutFromDay(convertDateTimeToString(day), workoutName);
    notifyListeners();
  }

  List<Workout> getAllWorkouts() {
    return WorkoutData().getWorkoutList();
  }
}