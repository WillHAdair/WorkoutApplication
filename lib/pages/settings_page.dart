import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/data/settings_data.dart';
import 'package:workout_app/data/theme_provider.dart';

import '../models/constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {

  Color selectedColor = Colors.green;
  bool darkMode = true;
  bool notificationsOn = false;
  bool trendTracking = false;
  @override
  void initState() {
    super.initState();
    final settingsData = Provider.of<SettingsData>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    settingsData.initializeSettingsList();
    darkMode = settingsData.getRelevantSetting("IsDarkMode").value as bool;
    notificationsOn =
        settingsData.getRelevantSetting("Notifications").value as bool;
    trendTracking =
        settingsData.getRelevantSetting("ProgressTracking").value as bool;

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      themeProvider.toggleTheme(darkMode);
    });
  }

  changeDarkMode(bool newThemeValue) {
    setState(() {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      final settingsData = Provider.of<SettingsData>(context, listen: false);
      settingsData.editSetting("IsDarkMode", newThemeValue);
      themeProvider.toggleTheme(newThemeValue);
      darkMode = newThemeValue;
    });
  }

  changeNotifications(bool newNotifications) {
    setState(() {
      notificationsOn = newNotifications;
      Provider.of<SettingsData>(context, listen: false)
          .editSetting("Notifications", newNotifications);
    });
  }

  changeTrendTracking(bool newTrendTracking) {
    setState(() {
      trendTracking = newTrendTracking;
      Provider.of<SettingsData>(context, listen: false)
          .editSetting("ProgressTracking", newTrendTracking);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(
                  Icons.palette,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text('Display',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            const Divider(height: 20, thickness: 1),
            const SizedBox(height: 10),
            //Let the user choose their display options
            buildColorOption("Select Primary Color", isPrimary: true),
            buildColorOption("Select Secondary Color", isSecondary: true),
            buildColorOption("Select Skip Day Color", isSkip: true),
            buildColorOption("Select Rest Day Color", isRest: true),
            buildColorOption("Select Rep counting Color", isMapBase: true),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(
                  Icons.toggle_off,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text('Preferences',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            const Divider(height: 20, thickness: 1),
            const SizedBox(height: 10),
            buildSwitch(Icons.light_mode, Icons.dark_mode, 'Theme Dark',
                darkMode, changeDarkMode),
            buildSwitch(Icons.notifications_off, Icons.notifications_active,
                'Notifications', notificationsOn, changeNotifications),
            buildSwitch(Icons.trending_flat, Icons.insights,
                'Progress Tracking', trendTracking, changeTrendTracking),
          ],
        ),
      ),
    );
  }

  Padding buildSwitch(IconData iconOff, IconData iconOn, String title,
      bool value, Function onChangeMethod) {
    IconData currentIcon = value ? iconOn : iconOff;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(currentIcon),
          Text(title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Provider.of<ThemeProvider>(context).constantText)),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.blue,
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue) {
                onChangeMethod(newValue);
                currentIcon = value ? iconOn : iconOff;
              },
            ),
          )
        ],
      ),
    );
  }

  Padding buildColorOption(String title,
      {bool isPrimary = false,
      bool isSecondary = false,
      bool isSkip = false,
      bool isRest = false,
      isMapBase = false}) {
    Color color;
    if (isPrimary) {
      color = Provider.of<ThemeProvider>(context).primaryColor;
    } else if (isSecondary) {
      color = Provider.of<ThemeProvider>(context).secondaryColor;
    } else if (isSkip) {
      color = Provider.of<ThemeProvider>(context).skipDayColor;
    } else if (isRest) {
      color = Provider.of<ThemeProvider>(context).restDayColor;
    } else if (isMapBase) {
      color = Provider.of<ThemeProvider>(context).heatMapBaseColor;
    } else {
      color = selectedColor;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => pickColor(context,
                isPrimary: isPrimary,
                isSecondary: isSecondary,
                isSkip: isSkip,
                isRest: isRest,
                isMapBase: isMapBase),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              width: 40,
              height: 40,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Provider.of<ThemeProvider>(context).constantText,
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () => pickColor(context,
                  isPrimary: isPrimary,
                  isSecondary: isSecondary,
                  isSkip: isSkip,
                  isRest: isRest,
                  isMapBase: isMapBase),
            ),
          ),
        ],
      ),
    );
  }

  void pickColor(BuildContext context,
          {bool isPrimary = false,
          bool isSecondary = false,
          bool isSkip = false,
          bool isRest = false,
          isMapBase = false}) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Pick color'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildColorPicker(
                  isPrimary: isPrimary,
                  isSecondary: isSecondary,
                  isSkip: isSkip,
                  isRest: isRest,
                  isMapBase: isMapBase),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Select',
                  style: TextStyle(
                    fontSize: 20,
                    color: Provider.of<ThemeProvider>(context).getTextColor(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildColorPicker(
      {bool isPrimary = false,
      bool isSecondary = false,
      bool isSkip = false,
      bool isRest = false,
      isMapBase = false}) {
    Color color;
    if (isPrimary) {
      color = Provider.of<ThemeProvider>(context).primaryColor;
    } else if (isSecondary) {
      color = Provider.of<ThemeProvider>(context).secondaryColor;
    } else if (isSkip) {
      color = Provider.of<ThemeProvider>(context).skipDayColor;
    } else if (isRest) {
      color = Provider.of<ThemeProvider>(context).restDayColor;
    } else if (isMapBase) {
      color = Provider.of<ThemeProvider>(context).heatMapBaseColor;
    } else {
      color = selectedColor;
    }

    return ColorPicker(
      pickerColor: color,
      onColorChanged: (newColor) {
        setState(() {
          if (isPrimary) {
            Provider.of<ThemeProvider>(context, listen: false)
                .setPrimaryColor(newColor);
          } else if (isSecondary) {
            Provider.of<ThemeProvider>(context, listen: false)
                .setSecondaryColor(newColor);
          } else if (isSkip) {
            Provider.of<ThemeProvider>(context, listen: false)
                .setSkipColor(newColor);
          } else if (isRest) {
            Provider.of<ThemeProvider>(context, listen: false)
                .setRestColor(newColor);
          } else if (isMapBase) {
            MaterialColor colorToMaterial = getMaterialColor(newColor);
            Provider.of<ThemeProvider>(context, listen: false)
                .setHeatMapBaseColor(colorToMaterial);
          } else {
            selectedColor = newColor;
          }
        });
      },
      enableAlpha: false,
      labelTypes: const [],
    );
  }
}
