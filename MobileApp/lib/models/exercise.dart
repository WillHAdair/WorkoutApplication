import 'package:workout_app/models/workout_set.dart';

abstract class Exercise {
  int id;
  String name;
  String? description;
  double? restTime;

  Exercise({
    required this.id,
    required this.name,
    this.description,
    this.restTime,
  });
}

class ContinualExercise extends Exercise {
  double time;
  double? weight;

  ContinualExercise({
    required super.id,
    required super.name,
    super.description,
    super.restTime,
    required this.time,
    this.weight,
  });
}

class SetsExercise extends Exercise {
  List<WorkoutSet> sets;

  SetsExercise({
    required super.id,
    required super.name,
    super.description,
    super.restTime,
    required this.sets,
  });
}

class CircuitExercise extends Exercise {
  List<Exercise> exercises;

  CircuitExercise({
    required super.id,
    required super.name,
    super.description,
    super.restTime,
    required this.exercises,
  });
}