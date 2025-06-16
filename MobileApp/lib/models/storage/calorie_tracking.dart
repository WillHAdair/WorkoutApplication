import 'package:isar/isar.dart';

part 'calorie_tracking.g.dart';

@Collection()
class CalorieTracking {
  Id id = Isar.autoIncrement;

  late int workoutDayCalories;
  late int restDayCalories;
}