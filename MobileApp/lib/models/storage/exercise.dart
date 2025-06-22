import 'package:isar/isar.dart';
import 'package:workout_app/models/constants.dart';
import 'workout_set.dart';

part 'exercise.g.dart';

@Collection()
class Exercise {
  Id id = Isar.autoIncrement;

  late String name;
  String? description;

  @enumerated
  late ExerciseType exerciseType;
  double? restTime;

  double? time;
  double? weight;

  final workoutSets = IsarLinks<WorkoutSet>();
  
  final exercises = IsarLinks<Exercise>();
}