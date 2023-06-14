import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.green.shade800,
  ),
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.green,
    secondary: Colors.green.shade500,
  ),
);