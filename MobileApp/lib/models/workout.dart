import 'exercise.dart';

abstract class Workout {
  int id;
  String name;
  String? description;

  Workout({
    required this.id,
    required this.name,
    this.description,
  });
}

class TimedWorkout extends Workout {
  int duration; // Duration in seconds
  double? weight; // Optional weight for the workout, if applicable

  TimedWorkout({
    required super.id,
    required super.name,
    super.description,
    required this.duration,
    double? weight,
  });
}

class ExercisesWorkout extends Workout {
  List<Exercise> exercises;
  double? restTime;

  ExercisesWorkout({
    required super.id,
    required super.name,
    super.description,
    required this.exercises,
    this.restTime,
  });
}