import 'package:hive/hive.dart';

import 'exercise.dart';

part 'workout.g.dart';
@HiveType(typeId: 77, adapterName: 'WorkoutAdapter')
class Workout {
  @HiveField(0)
  String name;
  @HiveField(1)
  final List<Exercise> exercises;

  Workout({required this.name, required this.exercises});
}