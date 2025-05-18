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