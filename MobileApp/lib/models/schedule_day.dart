import 'package:flutter/material.dart';
import 'package:workout_app/models/workout.dart';

class ScheduleDay {
  int id;
  String name;
  String? description;
  List<Workout> workouts;
  double? calorieGoal; // Nullable - if null, use user's maintenance calories
  TimeOfDay? startTime;

  ScheduleDay({
    required this.id,
    required this.name,
    this.description,
    required this.workouts,
    this.calorieGoal,
    this.startTime,
  });

  /// Gets the effective calorie goal for this day, using the provided maintenance calories
  /// as fallback if no specific calorie goal is set for this day.
  double getEffectiveCalorieGoal(double maintenanceCalories) {
    return calorieGoal ?? maintenanceCalories;
  }
}

extension ScheduleDayCopyWith on ScheduleDay {
  ScheduleDay copyWith({
    int? id,
    String? name,
    String? description,
    List<Workout>? workouts,
    double? calorieGoal,
    TimeOfDay? startTime,
  }) {
    return ScheduleDay(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      workouts: workouts ?? this.workouts,
      calorieGoal: calorieGoal ?? this.calorieGoal,
      startTime: startTime ?? this.startTime,
    );
  }
}