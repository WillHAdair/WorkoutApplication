import 'package:workout_app/models/calorie_tracking.dart';
import 'package:workout_app/models/schedule_day.dart';

class WorkoutSchedule {
  int id;
  String name;
  String? description;
  DateTime startDate;
  DateTime? endDate;
  bool isActive;
  List<ScheduleDay> days;
  CalorieTracking? calorieTracking;

  WorkoutSchedule({
    required this.id,
    required this.name,
    this.description,
    required this.startDate,
    this.endDate,
    required this.isActive,
    required this.days,
    this.calorieTracking,
  });
}

extension WorkoutScheduleCopyWith on WorkoutSchedule {
  WorkoutSchedule copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    List<ScheduleDay>? days,
    CalorieTracking? calorieTracking,
  }) {
    return WorkoutSchedule(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      days: days ?? this.days,
      calorieTracking: calorieTracking ?? this.calorieTracking,
    );
  }
}