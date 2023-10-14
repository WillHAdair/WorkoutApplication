import 'package:hive/hive.dart';

part 'workout_set.g.dart';

@HiveType(typeId: 80, adapterName: 'WorkoutSetAdapter')
class WorkoutSet {
  @HiveField(0)
  String weight;

  @HiveField(1)
  String reps;

  @HiveField(2)
  bool isCompleted;

  WorkoutSet({
    required this.weight,
    required this.reps,
    required this.isCompleted,
  });
}