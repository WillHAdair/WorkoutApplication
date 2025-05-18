import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/workout_set.dart';

abstract class Exercise {
  int id;
  String name;
  String? description;
  ExerciseType exerciseType;

  Exercise({
    required this.id,
    required this.name,
    this.description,
    required this.exerciseType,
  });
}

class ContinualExercise extends Exercise {
  double time;
  double? weight;

  ContinualExercise({
    required super.id,
    required super.name,
    super.description,
    required super.exerciseType,
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
    required super.exerciseType,
    required this.sets,
  });
}