import 'package:hive/hive.dart';
import 'package:workout_app/datetime/date_timedata.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/setting.dart';

import '../models/workout.dart';

late Box boxWorkouts;
late Box boxSettings;
class HiveDatabase {
  // Common
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

  final workoutBox = Hive.box<Workout>("workoutBox");
  // Workouts
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

  final settingsBox = Hive.box<Setting>("settingsBox");
  // Settings

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

  final programDataBox = Hive.box("programDataBox");
  // ProgramData
  int getDailyCompletion(String date) {
    return programDataBox.get("${keyMap[Keys.completion]}_$date") ?? 0;
  }

  void setDailyCompletion(String date, int amount) {
    programDataBox.put("${keyMap[Keys.completion]}_$date", amount);
  }

  void addWorkoutsToDay(String date, List<String> workoutNames) {
    List<String> priorWorkouts = getWorkoutsForDay(date);
    for (String workoutName in workoutNames) {
      if (!priorWorkouts.contains(workoutName)) {
        priorWorkouts.add(workoutName);
      }
    }
    programDataBox.put("${keyMap[Keys.workoutDay]}_$date", priorWorkouts);
  }

  List<String> getWorkoutsForDay(String date) {
    return programDataBox.get("${keyMap[Keys.workoutDay]}_$date") ?? [];
  }

  void deleteWorkoutFromDay(String date, String workoutName) {
    List<String> workouts = getWorkoutsForDay(date);
    if (workouts.contains(workoutName)) {
      workouts.remove(workoutName);
    }
    addWorkoutsToDay(date, workouts);
  }

  void changeWorkoutStarted(bool newStatus) {
    programDataBox.put(keyMap[Keys.workoutStarted], newStatus);
  }

  bool checkWorkoutStarted() {
    if (!selectedKeyFound(programDataBox,keyMap[Keys.workoutStarted]!)) {
      changeWorkoutStarted(false);
      return false;
    }
    return programDataBox.get(keyMap[Keys.workoutStarted]);
  }
}