import 'package:isar/isar.dart';
import 'package:workout_app/models/constants.dart';

part 'workout_set.g.dart';

@Collection()
class WorkoutSet {
  Id id = Isar.autoIncrement;

  String? description;
  double? restTime;
  late bool isBodyWeight;

  @enumerated
  late WorkoutSetType setType;

  double? duration;
  double? weight;
  int? reps;

  List<double>? weightList;
  List<int?>? repsList;
}