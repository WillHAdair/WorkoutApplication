import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/pages/nav_bar.dart';
import 'package:workout_app/data/theme_provider.dart';

import 'data/workout_data.dart';

void main() async {
  
  await Hive.initFlutter();

  await Hive.openBox("workout_database");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WorkoutData(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:  false,
      home: const BottomNavigation(),
      themeMode:  Provider.of<ThemeProvider>(context).themeMode,
      theme: Provider.of<ThemeProvider>(context).lightTheme,
      darkTheme: Provider.of<ThemeProvider>(context).darkTheme,
    );
  }
}

