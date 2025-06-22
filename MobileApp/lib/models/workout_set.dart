abstract class WorkoutSet {
  int id;
  String? description;
  double? restTime;
  bool isBodyWeight = false;

  WorkoutSet({
    required this.id,
    this.description,
    this.restTime,
    this.isBodyWeight = false,
  });
}

class TimedSet extends WorkoutSet {
  double duration;
  double? weight;

  TimedSet({
    required super.id,
    super.description,
    super.restTime,
    super.isBodyWeight = false,
    required this.duration,
    this.weight,
  });
}

class RepsSet extends WorkoutSet {
  double weight;
  int? reps; // null indicates to failure

  RepsSet({
    required super.id,
    super.description,
    super.restTime,
    super.isBodyWeight = false,
    required this.weight,
    this.reps,
  });
}

class DropSet extends WorkoutSet {
  Map<double, int?> weightRepsMap;

  DropSet({
    required super.id,
    super.description,
    super.restTime,
    super.isBodyWeight = false,
    required this.weightRepsMap,
  });
}
