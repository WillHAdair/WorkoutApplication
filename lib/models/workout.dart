import 'exercise.dart';

class Workout {
  int id;
  String name;
  String? description;
  List<Exercise> exercises;

  Workout({
    required this.id,
    required this.name,
    this.description,
    required this.exercises,
  });
}