import 'package:isar/isar.dart';
import 'package:workout_app/models/constants.dart';

part 'workout_set.g.dart';

@Collection()
class WorkoutSet {
  Id id = Isar.autoIncrement;

  double? restTime;

  @enumerated
  late SetType setType;

  // This is for a super set:
  // If there are exercsises, their ids will be listed here
  late List<int>? exercises;

  double? duration;
  double? weight;

  List<double>? weights;
  List<int>? reps;
}