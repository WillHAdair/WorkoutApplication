import 'package:workout_app/models/past_schedule_day.dart';
import 'package:workout_app/models/workout_schedule.dart';

class UserProfile {
  int id;
  String userName;
  double? height;
  double? weight;
  double? maintenanceCalories;
  List<PastScheduleDay> pastScheduleDays;
  List<WorkoutSchedule> schedules;
  DateTime lastUpdated;

  UserProfile({
    required this.id,
    required this.userName,
    this.height,
    this.weight,
    this.maintenanceCalories,
    required this.pastScheduleDays,
    required this.schedules,
    required this.lastUpdated,
  });
}

extension UserProfileCopyWith on UserProfile {
  UserProfile copyWith({
    int? id,
    String? userName,
    double? height,
    double? weight,
    List<PastScheduleDay>? pastScheduleDays,
    List<WorkoutSchedule>? schedules,
    DateTime? lastUpdated,
  }) {
    return UserProfile(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      pastScheduleDays: pastScheduleDays ?? this.pastScheduleDays,
      schedules: schedules ?? this.schedules,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}