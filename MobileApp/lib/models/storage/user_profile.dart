import 'package:isar/isar.dart';
import 'package:workout_app/models/storage/past_schedule_day.dart';
import 'package:workout_app/models/storage/workout_schedule.dart';

part 'user_profile.g.dart';

@Collection()
class UserProfile {
  Id id = Isar.autoIncrement;

  late String userName;
  late double? height;
  late double? weight;
  late double? maintenanceCalories;

  final pastScheduleDays = IsarLinks<PastScheduleDay>();
  final schedules = IsarLinks<WorkoutSchedule>();
  late DateTime lastUpdated;
}