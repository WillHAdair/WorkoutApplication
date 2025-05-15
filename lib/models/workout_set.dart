import 'package:isar/isar.dart';
import 'package:workout_app/models/constants.dart';

part 'workout_set.g.dart';

@Collection()
class WorkoutSet {
  Id id = Isar.autoIncrement;

  double? restTime;

  @enumerated
  late SetType setType;

  double? duration;
  double? weight;

  List<double>? weights;
  List<int>? reps;
  List<String>? exercises;

  bool get isTimeSet => setType == SetType.time;

  bool get isRepsSet => setType == SetType.reps;
}