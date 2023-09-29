import 'package:workout_app/models/workout.dart';

class Tracker {
  String name;
  List<Workout> workouts;

  Tracker({
    required this.name,
    required this.workouts,
  });
}