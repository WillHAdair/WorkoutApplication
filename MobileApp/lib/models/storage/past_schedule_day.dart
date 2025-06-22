import 'package:isar/isar.dart';
import 'package:workout_app/models/storage/workout.dart';
import 'package:workout_app/models/storage/workout_schedule.dart';

part 'past_schedule_day.g.dart';

@Collection()
class PastScheduleDay {
  Id id = Isar.autoIncrement;

  final schedule = IsarLink<WorkoutSchedule>();
  final workouts = IsarLinks<Workout>();
  List<double>? completionPercentages;

  late DateTime day;
  String? startTime;
  String? endTime;
  double? caloriesGoal;
  double? caloriesBurned;
}