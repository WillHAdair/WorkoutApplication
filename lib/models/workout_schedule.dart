import 'package:workout_app/models/calorie_tracking.dart';
import 'package:workout_app/models/schedule_day.dart';
import 'package:workout_app/models/user_profile.dart';

class WorkoutSchedule {
  int id;
  String name;
  String? description;
  DateTime startDate;
  DateTime? endDate;
  bool isActive;
  List<ScheduleDay> days;
  CalorieTracking? calorieTracking;
  UserProfile userProfile;

  WorkoutSchedule({
    required this.id,
    required this.name,
    this.description,
    required this.startDate,
    this.endDate,
    required this.isActive,
    required this.days,
    this.calorieTracking,
    required this.userProfile,
  });
}

extension WorkoutScheduleCopyWith on WorkoutSchedule {
  WorkoutSchedule copyWith({
    int? id,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    UserProfile? userProfile,
    List<ScheduleDay>? days,
  }) {
    return WorkoutSchedule(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      userProfile: userProfile ?? this.userProfile,
      days: days ?? this.days,
    );
  }
}