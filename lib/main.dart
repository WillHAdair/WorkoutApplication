import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/data/settings_data.dart';
import 'package:workout_app/models/exercise.dart';
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
  await Hive.openBox<Workout>("workoutBox");
  await Hive.openBox<Setting>("settingsBox");
  await Hive.openBox("programDataBox");

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => WorkoutData()),
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => SettingsData()),
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
