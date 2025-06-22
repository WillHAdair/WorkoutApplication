import 'package:isar/isar.dart';
import 'package:workout_app/models/constants.dart';
import 'exercise.dart';

part 'workout.g.dart';

@Collection()
class Workout {
  Id id = Isar.autoIncrement;

  late String name;
  String? description;

  @enumerated
  late WorkoutType workoutType; // Type of workout (e.g., Timed, Exercises)

  int? duration; // Duration in seconds, for timed workouts
  double? weight; // Optional weight for the workout, if applicable (timed workouts)

  final exercises = IsarLinks<Exercise>();
  double? restTime; // Optional rest time for the workout, applicable for exercises workouts
}