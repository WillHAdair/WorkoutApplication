import 'package:flutter/material.dart';
import 'package:workout_app/models/workout.dart';

class PastScheduleDay {
  int id;
  int scheduleID;
  Map<Workout, double>? workoutCompletionMap;
  DateTime day;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  double? caloriesGoal;
  double? caloriesBurned;

  PastScheduleDay({
    required this.id,
    required this.scheduleID,
    this.workoutCompletionMap,
    required this.day,
    this.startTime,
    this.endTime,
    this.caloriesGoal,
    this.caloriesBurned,
  });
}
