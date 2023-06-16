import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  Color primaryColor = Colors.green;
  Color secondaryColor = Colors.green.shade500;
  Color restDayColor = Colors.cyan.shade400;
  Color skipDayColor = Colors.red.shade300;
  MaterialColor heatMapBaseColor = Colors.green;

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
