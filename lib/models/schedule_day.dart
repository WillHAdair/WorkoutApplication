import 'package:workout_app/models/workout.dart';

class ScheduleDay {
  int id;
  String name;
  List<Workout> workouts;

  ScheduleDay({
    required this.id,
    required this.name,
    required this.workouts,
  });
}