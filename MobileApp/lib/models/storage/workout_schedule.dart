import 'package:isar/isar.dart';
import 'schedule_day.dart';
import 'calorie_tracking.dart';

part 'workout_schedule.g.dart';

@Collection()
class WorkoutSchedule {
  Id id = Isar.autoIncrement;

  late String name;
  String? description;

  late DateTime startDate;
  DateTime? endDate;

  late bool isActive;

  final days = IsarLinks<ScheduleDay>();
  final calorieTracking = IsarLink<CalorieTracking>();
}