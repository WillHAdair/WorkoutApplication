import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/utils/settings.dart';

class ThemeProvider extends ChangeNotifier {
  ///Theme Data
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      return PlatformDispatcher.instance.platformBrightness == Brightness.dark;
    }
    return themeMode == ThemeMode.dark;
  }
  
  //Text
  Color lightText = Colors.black;
  Color darkText = Colors.white;
  Color getTextColor() {
    return isDarkMode ? darkText : lightText;
  }

  //Background
  Color lightBackground = Colors.grey.shade200;
  Color darkBackground = Colors.grey.shade900;
  Color getBackgroundColor() {
    return isDarkMode ? darkBackground : lightBackground;
  }

  //App Bar
  Color lightAppBar = Colors.grey.shade400;
  Color darkAppBar = Colors.grey.shade900;
  Color getAppBarColor() {
    return isDarkMode ? darkAppBar : lightAppBar;
  }

  //Popup
  Color lightPopupBackground = Colors.grey.shade300;
  Color darkPopupBackground = Colors.grey.shade800;
  Color getPopupBackgroundColor() {
    return isDarkMode ? darkPopupBackground : lightPopupBackground;
  }

  //Dropdown
  Color lightDropdownBackground = Colors.grey.shade300;
  Color darkDropdownBackground = Colors.grey.shade800;
  Color getDropdownBackgroundColor() {
    return isDarkMode ? darkDropdownBackground : lightDropdownBackground;
  }

  //Buttons
  Color closeButton = Colors.grey.shade400;
  Color lightButtonBackground = Colors.grey.shade400;
  Color darkButtonBackground = Colors.grey.shade700;
  Color getButtonBackground() {
    return isDarkMode ? darkButtonBackground : lightButtonBackground;
  }

  //Header
  Color lightHeaderBackground = Colors.grey.shade400;
  Color darkHeaderBackground = Colors.grey.shade800;
  Color getHeaderBackgroundColor() {
    return isDarkMode ? darkHeaderBackground : lightHeaderBackground;
  }

  //Heatmap
  Color lightHeatmapBackground = Colors.grey.shade300;
  Color getHeatmapBackgroundColor() {
    return isDarkMode ? darkBackground : lightHeatmapBackground;
  }

  Color lightHeatMapBaseColor = Colors.grey.shade400;
  Color darkHeatMapBaseColor = Colors.grey.shade300;
  Color getHeatMapBaseColor() {
    return isDarkMode ? darkHeatMapBaseColor : lightHeatMapBaseColor;
  }

  MaterialColor heatMapColor = Colors.green;

  //Navigation Bar
  Color navBarBackground = Colors.black;
  Color navBarText = Colors.white;
  Color navBarHighlightBackground = Colors.grey.shade800;

  //Program colors
  Color primaryColor = const Color.fromRGBO(34, 139, 34, 1); // Modern green
  Color secondaryColor = const Color.fromARGB(255, 50, 205, 50);
  Color acceptColor = const Color.fromRGBO(44, 206, 63, 1);
  Color rejectColor = const Color.fromRGBO(255, 0, 20, 1);
  Color buttonColor = Colors.grey.shade800;

  /// Get themes
  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
        ),
        colorScheme: ColorScheme.light(
          surface: Colors.white,
          primary: primaryColor,
          secondary: secondaryColor,
        ),
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
        ),
        colorScheme: ColorScheme.dark(
          surface: Colors.grey.shade900,
          primary: primaryColor,
          secondary: secondaryColor,
        ),
      );

  void syncWithSettings(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    themeMode = settings.isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleTheme(BuildContext context, bool darkMode) async {
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    await settings.setDarkMode(darkMode);
    themeMode = darkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }  
}