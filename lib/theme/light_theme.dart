import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.green.shade800,
  ),
    colorScheme: ColorScheme.light(
      background: Colors.grey.shade100,
      primary: Colors.green,
      secondary: Colors.green.shade500,
  ),
);