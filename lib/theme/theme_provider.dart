import 'package:flutter/material.dart';
import 'package:workout_app/theme/dark_theme.dart';
import 'package:workout_app/theme/light_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  ThemeData dark = darkTheme;
  ThemeData light = lightTheme;

  void toggleTheme(bool newThemeValue) {
    themeMode = newThemeValue ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}