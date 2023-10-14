import 'package:hive/hive.dart';
import 'package:workout_app/models/workout_set.dart';

part 'exercise.g.dart';

@HiveType(typeId: 78, adapterName: 'ExerciseAdapter')
class Exercise {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<WorkoutSet> sets;

  @HiveField(2)
  bool isCompleted;

  Exercise({
    required this.name,
    required this.sets,
    required this.isCompleted,
  });
}