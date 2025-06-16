import 'package:isar/isar.dart';
import 'workout.dart';

part 'schedule_day.g.dart';

@Collection()
class ScheduleDay {
  Id id = Isar.autoIncrement;

  late String dayName;
  
  double? calorieGoal; // Nullable - if null, use user's maintenance calories

  final workouts = IsarLinks<Workout>();
}