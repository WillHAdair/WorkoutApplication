import 'package:isar/isar.dart';
import 'exercise.dart';

part 'workout.g.dart';

@Collection()
class Workout {
  Id id = Isar.autoIncrement;

  late String name;
  String? description;

  final exercises = IsarLinks<Exercise>();
}