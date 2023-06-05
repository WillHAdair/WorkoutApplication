import 'package:flutter/material.dart';
import 'package:workout_app/Login/login.dart';
import 'Home/home.dart';

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: LoginPage(),
      home: const HomePage(titles: ['Home Page', 'Workouts Page', 'Settings Page']),
    );
  }
}
