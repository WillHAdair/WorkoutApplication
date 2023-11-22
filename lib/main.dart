import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/data/schedule_data.dart';
import 'package:workout_app/data/settings_data.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/schedule.dart';
import 'package:workout_app/models/setting.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/models/workout_set.dart';
import 'package:workout_app/pages/nav_bar.dart';
import 'package:workout_app/data/theme_provider.dart';

import 'data/workout_data.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutSetAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(SettingAdapter());
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(ScheduleAdapter());
  await Hive.openBox<Workout>(boxKeyMap[BoxKeys.workouts].toString());
  await Hive.openBox<Setting>(boxKeyMap[BoxKeys.settings].toString());
  await Hive.openBox<Schedule>(boxKeyMap[BoxKeys.schedules].toString());
  await Hive.openBox(boxKeyMap[BoxKeys.programData].toString());

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => WorkoutData()),
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => SettingsData()),
    ChangeNotifierProvider(create: (context) => ScheduleData()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BottomNavigation(),
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      theme: Provider.of<ThemeProvider>(context).lightTheme,
      darkTheme: Provider.of<ThemeProvider>(context).darkTheme,
    );
  }
}
