import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/utils/settings.dart';
import 'package:workout_app/utils/themes.dart';
import 'package:workout_app/pages/navigation_page.dart';
import 'package:workout_app/utils/workouts.dart';

void main() {
  runApp(MultiProvider(providers: [
      ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ChangeNotifierProvider<SettingsProvider>(create: (_) => SettingsProvider()),
      ChangeNotifierProvider<WorkoutsProvider>(create: (_) => WorkoutsProvider()),
    ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const NavigationPage(),
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      theme: Provider.of<ThemeProvider>(context).lightTheme,
      darkTheme: Provider.of<ThemeProvider>(context).darkTheme,
    );
  }
}
