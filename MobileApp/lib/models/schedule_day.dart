import 'package:workout_app/models/workout.dart';

class ScheduleDay {
  int id;
  String name;
  List<Workout> workouts;
  double? calorieGoal; // Nullable - if null, use user's maintenance calories

  ScheduleDay({
    required this.id,
    required this.name,
    required this.workouts,
    this.calorieGoal,
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
    List<Workout>? workouts,
    double? calorieGoal,
  }) {
    return ScheduleDay(
      id: id ?? this.id,
      name: name ?? this.name,
      workouts: workouts ?? this.workouts,
      calorieGoal: calorieGoal ?? this.calorieGoal,
    );
  }
}