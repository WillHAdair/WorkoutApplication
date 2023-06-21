import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ///Theme Data
  ThemeMode themeMode = ThemeMode.dark;
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
  Color primaryColor = const Color.fromRGBO(76, 175, 80, 1);
  Color secondaryColor = const Color.fromRGBO(76, 175, 80, 1);

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
          background: Colors.grey.shade100,
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
  void toggleTheme(bool newThemeValue) {
    themeMode = newThemeValue ? ThemeMode.dark : ThemeMode.light;
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

  MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }
}
