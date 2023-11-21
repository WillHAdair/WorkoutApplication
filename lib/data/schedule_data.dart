import 'package:flutter/material.dart';
import 'package:workout_app/data/hive_database.dart';
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
      workoutList = db.rea
    }
  }
}