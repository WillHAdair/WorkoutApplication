import 'package:workout_app/models/constants.dart';

abstract class WorkoutSet {
  int id;
  double? restTime;
  SetType setType;

  WorkoutSet({
    required this.id,
    this.restTime,
    required this.setType,
  });
}

class TimedSet extends WorkoutSet {
  double duration;
  double weight;

  TimedSet({
    required super.setType,
    required super.id,
    super.restTime,
    required this.duration,
    required this.weight,
  });
}

class WeightedSet extends WorkoutSet {
  double weight;
  int? reps;

  WeightedSet({
    required super.setType,
    required super.id,
    super.restTime,
    required this.weight,
    this.reps,
  });
}

class DropSet extends WorkoutSet {
  List<int> reps;
  List<double> weights;

  DropSet({
    required super.setType,
    required super.id,
    super.restTime,
    required this.reps,
    required this.weights,
  });
}

class SuperSet extends WorkoutSet {
  List<int> exercises;
  List<int> reps;
  List<double> weights;

  SuperSet({
    required super.setType,
    required super.id,
    super.restTime,
    required this.exercises,
    required this.reps,
    required this.weights,
  });
}
