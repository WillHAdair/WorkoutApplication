import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:workout_app/datetime/date_timedata.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/setting.dart';

import '../models/workout.dart';

class HiveDatabase {
  final _myBox = Hive.box("workout_database");

  bool selectedKeyFound(String key) {
    var value = _myBox.get(key);
    if (value == null) {
      return false;
    }
    return true;
  }

  bool previousDataExists() {
    if (_myBox.isEmpty) {
      if (kDebugMode) {
        print("previous data not here");
      }
      _myBox.put("START_DATE", todaysDate());
      return false;
    } else {
      if (kDebugMode) {
        print("previous data is here");
      }
      return true;
    }
  }

  String getStartDate() {
    var startDate = _myBox.get("START_DATE");
    if (startDate == null) {
      _myBox.put("START_DATE", todaysDate());
      return todaysDate();
    }
    return startDate;
  }

  Color? getColor(String colorName) {
    int color = _myBox.get(colorName);
    return !color.isUndefinedOrNull ? Color(color) : null;
  }

  void setColor(String colorName, Color color) {
    _myBox.put(colorName, color.value);
  }

  void saveSettings(List<Setting> settings) {
    List<List<String>> settingsList = convertSettingsToList(settings);
    _myBox.put("SETTINGS", settingsList);
  }

  List<Setting> readSettings() {
    List<List<String>> settingsList = _myBox.get("SETTINGS");
    return convertListToSettings(settingsList);
  }

  void saveWorkouts(List<Workout> workouts) {
    final List<String> workoutList = convertWorkoutsToList(workouts);
    final List<List<List<String>>> exerciseList =
        convertExercisesToList(workouts);

    _myBox.put(
        "COMPLETION_STATUS_${todaysDate()}", getCompletedExercises(workouts));

    _myBox.put("WORKOUTS", workoutList);
    _myBox.put("EXERCISES", exerciseList);
  }

  List<Workout> readWorkouts() {
    if (!selectedKeyFound("WORKOUTS") || !selectedKeyFound("EXERCISES")) {
      return [];
    }
    List<Workout> mySavedWorkouts = [];
    List<String> workoutNames = _myBox.get("WORKOUTS");
    final exerciseDetails = _myBox.get("EXERCISES");

    for (int i = 0; i < workoutNames.length; i++) {
      List<Exercise> exercisesPerWorkout = [];

      for (int j = 0; j < exerciseDetails[i].length; j++) {
        exercisesPerWorkout.add(Exercise(
          name: exerciseDetails[i][j][0],
          weight: exerciseDetails[i][j][1],
          reps: exerciseDetails[i][j][2],
          sets: exerciseDetails[i][j][3],
          isCompleted: exerciseDetails[i][j][4] == "true" ? true : false,
        ));
      }

      Workout workout =
          Workout(name: workoutNames[i], exercises: exercisesPerWorkout);

      mySavedWorkouts.add(workout);
    }
    return mySavedWorkouts;
  }

  int getCompletedExercises(List<Workout> workouts) {
    int completedExercies = 0;
    for (Workout workout in workouts) {
      for (Exercise exercise in workout.exercises) {
        if (exercise.isCompleted) {
          completedExercies++;
        }
      }
    }
    return completedExercies;
  }

  int getCompletionStatus(String date) {
    return _myBox.get("COMPLETION_STATUS_$date") ?? 0;
  }
}

List<String> convertWorkoutsToList(List<Workout> workouts) {
  List<String> workoutList = [];

  for (Workout workout in workouts) {
    workoutList.add(workout.name);
  }

  return workoutList;
}

List<List<List<String>>> convertExercisesToList(List<Workout> workouts) {
  List<List<List<String>>> exerciseList = [];

  for (Workout workout in workouts) {
    List<Exercise> exercisesInWorkout = workout.exercises;
    List<List<String>> individualWorkout = [];

    for (Exercise exercise in exercisesInWorkout) {
      List<String> individualExercise = [];

      individualExercise.addAll([
        exercise.name,
        exercise.weight,
        exercise.reps,
        exercise.sets,
        exercise.isCompleted.toString(),
      ]);
      individualWorkout.add(individualExercise);
    }

    exerciseList.add(individualWorkout);
  }

  return exerciseList;
}

List<List<String>> convertSettingsToList(List<Setting> settings) {
  List<List<String>> settingList = [];
  for (Setting setting in settings) {
    String settingValue = '';
    switch (setting.type) {
      case SettingType.string:
        settingValue = setting.value;
        break;
      case SettingType.boolean:
        settingValue = (setting.value as bool).toString();
        break;
      case SettingType.color:
        settingValue = (setting.value as Color).value.toString();
        break;
      case SettingType.materialColor:
        settingValue = (setting.value as MaterialColor).value.toString();
        break;
      case SettingType.empty:
        break;
    }
    settingList.add([
      setting.name,
      setting.type.toString(),
      settingValue,
    ]);
  }
  return settingList;
}

List<Setting> convertListToSettings(List<List<String>> settingStrings) {
  List<Setting> settings = [];
  for (List<String> settingString in settingStrings) {
    String name = settingString[0];
    SettingType type = SettingType.empty;
    type = SettingType.values.firstWhere(
        (settingType) => settingString[1] == settingType.toString());
    String stringValue = settingString[2];
    var value;
    // Empty and String are already correct, so set to default
    switch (type) {
      case SettingType.boolean:
        value = bool.parse(stringValue);
        break;
      case SettingType.color:
        value = Color(int.parse(stringValue));
        break;
      case SettingType.materialColor:
        Color color = Color(int.parse(stringValue));
        value = getMaterialColor(color);
        break;
      default:
        value = stringValue;
        break;
    }
    settings.add(Setting(name: name, type: type, value: value));
  }
  return settings;
}
