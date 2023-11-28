// How to model the Rep Type, (i.e do you do set number of reps, or just time, or go to failure)
import 'package:flutter/material.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/workout.dart';

enum RepType {
  time,
  counted,
  timeFailure,
  countedFailure,
  warmup,
}

// What is the exercise purpose, this influences how the suggestions regarding weight are discussed
enum ExercisePurpose {
  corrective, //just to keep you going
  cardio,
  hypertrophy,
  warmup //this is different from RepType.warmup because this is the purpose of the entire exercise
}

Workout restWorkout = Workout(name: "break", exercises: []);
Exercise standIn = Exercise(name: "", sets: [], isCompleted: false);

// Modeling the type of Weight used (i.e is it just the number value, % of 1RM, or not weighted at all)
enum WeightType { fixedValue, percentORM, notApplicable }

// Modeling the type of setting we are using
enum SettingType { string, boolean, color, materialColor, empty }

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };
  return MaterialColor(color.value, shades);
}

String dumbellImg = 'lib/images/dumbell.png';

enum BoxKeys {
  settings,
  programData,
  workouts,
  schedules,
}

Map<BoxKeys, String> boxKeyMap = {
  BoxKeys.settings: "settingsBox",
  BoxKeys.workouts: "workoutBox",
  BoxKeys.programData: "programDataBox",
  BoxKeys.schedules: "schedulesBox",
};

enum Keys {
  startDate,
  notifications,
  theme,
  progressTracking,
  remoteData,
  completion,
  workout,
  workoutDay,
  workoutStarted,
  startedWorkout,
  currentSchedule,
  firstName,
  lastName,
  age,
  weight,
  height,
}

Map<Keys, String> keyMap = {
  Keys.startDate: "START_DATE",
  Keys.notifications: "NOTIFICATIONS",
  Keys.theme: "THEME",
  Keys.progressTracking: "PROGRESS",
  Keys.remoteData: "REMOTE_DATA",
  Keys.completion: "COMPLETED_EXERCISES",
  Keys.workout: "WORKOUT",
  Keys.workoutDay: "WORKOUT_DAY",
  Keys.workoutStarted: "WORKOUT_STARTED",
  Keys.startedWorkout: "STARTED_WORKOUT",
  Keys.currentSchedule: "CURRENT_SCHEDULE",
  Keys.firstName: "FIRST_NAME",
  Keys.lastName: "LAST_NAME",
  Keys.age: "AGE",
  Keys.weight: "WEIGHT",
  Keys.height: "HEIGHT",
};
