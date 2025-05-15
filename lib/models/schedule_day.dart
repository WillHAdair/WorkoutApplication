import 'package:isar/isar.dart';
import 'workout.dart';

part 'schedule_day.g.dart';

@Collection()
class ScheduleDay {
  Id id = Isar.autoIncrement;

  late int dayNumber;

  final workouts = IsarLinks<Workout>();
  bool isRestDay = false;
}