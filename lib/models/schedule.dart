import 'package:hive/hive.dart';

import 'package:workout_app/models/workout.dart';

part 'schedule.g.dart';

@HiveType(typeId: 81, adapterName: 'ScheduleAdapter')
class Schedule {
  @HiveField(0)
  String name;
  @HiveField(1)
  int period;
  @HiveField(2)
  List<Workout> workouts;
  @HiveField(3)
  bool? isCurrent;
  @HiveField(4)
  DateTime? startDate;

  Schedule({
    required this.name,
    required this.period,
    required this.workouts,
  });
}