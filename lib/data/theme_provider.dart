import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ///Theme Data
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  ///Non-customizable widget colors

  //Tiles
  Color tileLight = Colors.grey.shade300;
  Color tileDark = Colors.grey.shade800;
  Color tileCompleted = const Color.fromARGB(255, 53, 153, 57);
  Color getTileColor() {
    return isDarkMode ? tileDark : tileLight;
  }

  Color settingsTile = Colors.grey.shade800;
  Color deleteTile = Colors.red.shade300;

  // Generic colors
  Color programGreen = const Color.fromARGB(168, 230, 207, 1);

  //Chips
  Color chipLight = Colors.grey.shade500;
  Color chipDark = Colors.grey.shade900;
  Color chipCompleted = const Color.fromARGB(255, 39, 117, 42);
  Color getChipcolor() {
    return isDarkMode ? chipDark : chipLight;
  }

  //Text
  Color lightText = Colors.black;
  Color darkText = Colors.white;
  Color acceptText = Colors.green;
  Color cancelText = Colors.red;
  Color constantText = Colors.grey.shade600;
  Color getTextColor() {
    return isDarkMode ? darkText : lightText;
  }

  ///Color customization

  //Program colors
  Color primaryColor = const Color.fromRGBO(0, 153, 255, 1);
  Color secondaryColor = const Color.fromARGB(255, 7, 65, 255);
  Color acceptColor = const Color.fromRGBO(44, 206, 63, 1);
  Color rejectColor = const Color.fromRGBO(255, 0, 20, 1);

  //Heat map colors
  Color restDayColor = const Color.fromRGBO(38, 198, 218, 1);
  Color skipDayColor = const Color.fromRGBO(229, 115, 115, 1);
  MaterialColor heatMapBaseColor = Colors.green;

  /// Get themes
  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
        ),
        colorScheme: ColorScheme.light(
          background: Colors.white,
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
          background: Colors.grey.shade900,
          primary: primaryColor,
          secondary: secondaryColor,
        ),
      );

  /// Toggling colors
  void toggleTheme(bool darkMode) {
    themeMode = darkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setPrimaryColor(Color color) {
    primaryColor = color;
    notifyListeners();
  }

  void setSecondaryColor(Color color) {
    secondaryColor = color;
    notifyListeners();
  }

  void setRestColor(Color color) {
    restDayColor = color;
    notifyListeners();
  }

  void setSkipColor(Color color) {
    skipDayColor = color;
    notifyListeners();
  }

  void setHeatMapBaseColor(MaterialColor color) {
    heatMapBaseColor = color;
    notifyListeners();
  }

  void initializeState(bool darkMode, Color primary, Color secondary,
      Color skip, Color rest, MaterialColor heatMap) {
    themeMode = darkMode ? ThemeMode.dark : ThemeMode.light;
    primaryColor = primary;
    secondaryColor = secondary;
    skipDayColor = skip;
    restDayColor = rest;
    heatMapBaseColor = heatMap;
  }
}
