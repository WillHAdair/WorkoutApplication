import 'package:isar/isar.dart';
import 'workout.dart';

part 'schedule_day.g.dart';

@Collection()
class ScheduleDay {
  Id id = Isar.autoIncrement;

  late String dayName;

  final workouts = IsarLinks<Workout>();
}