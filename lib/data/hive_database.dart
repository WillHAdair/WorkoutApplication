import 'package:hive/hive.dart';
import 'package:workout_app/datetime/date_timedata.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/setting.dart';

import '../models/workout.dart';

late Box boxWorkouts;
late Box boxSettings;
class HiveDatabase {
  final workoutBox = Hive.box<Workout>("workoutBox");
  final settingsBox = Hive.box<Setting>("settingsBox");
  final programDataBox = Hive.box("programDataBox");


  bool selectedKeyFound(Box box, String key) {
    return box.get(key) != null;
  }

  String getStartDate() {
    if (!selectedKeyFound(programDataBox, keyMap[Keys.startDate].toString())) {
      programDataBox.put(keyMap[Keys.startDate].toString(), todaysDate());
      return todaysDate();
    }
    return programDataBox.get(keyMap[Keys.startDate]);
  }

  Setting? getSetting(String key) {
    return selectedKeyFound(settingsBox, key) ? settingsBox.get(key) : null;
  }

  void saveSetting(String key, Setting setting) {
    settingsBox.put(key, setting);
  }

  void saveSettings(Map<String, Setting> settings) {
    settingsBox.putAll(settings);
  }

  List<Setting> readSettings() {
    return settingsBox.values.isNotEmpty ? settingsBox.values.toList() : [];
  }

  void saveWorkout(String key, Workout workout) {
    workoutBox.put(key, workout);
  }

  void deleteWorkout(String key) {
    workoutBox.delete(key);
  }

  void saveWorkouts(Map<String, Workout> workouts) {
    workoutBox.putAll(workouts);
  }

  Workout? readWorkout(String key) {
    return selectedKeyFound(workoutBox, key) ? workoutBox.get(key) : null;
  }

  List<Workout> readAllWorkouts() {
    return workoutBox.values.toList();
  }

  int getDailyCompletion(String date) {
    return programDataBox.get("${keyMap[Keys.completion]}_$date") ?? 0;
  }

  void setDailyCompletion(String date, int amount) {
    programDataBox.put("${keyMap[Keys.completion]}_$date", amount);
  }
}