import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/data/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override 
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  
  Color selectedColor = Colors.green;
  bool isDarkMode = true;
  bool valNotify2 = false;
  bool valNotify3 = false;

  changeDarkMode(bool newThemeValue) {
    setState(() {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      themeProvider.toggleTheme(newThemeValue);
      isDarkMode = newThemeValue;
    });
  }
  
  onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  onChangeFunction3(bool newValue3) {
    setState(() {
      valNotify3 = newValue3;
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
                Text('Display', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            const Divider(height: 20, thickness:  1),
            const SizedBox(height: 10),
            //Let the user choose their display options
            buildColorOption("Select Primary Color", isPrimary: true),
            buildColorOption("Select secondary Color", isSecondary: true),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(
                  Icons.toggle_off,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text('Preferences', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            const Divider(height: 20, thickness:  1),
            const SizedBox(height: 10),
            buildSwitch(Icons.light_mode, Icons.dark_mode, 'Theme Dark', isDarkMode, changeDarkMode),
            buildSwitch(Icons.notifications_off, Icons.notifications_active, 'Notifications', valNotify2, onChangeFunction2),
            buildSwitch(Icons.trending_flat, Icons.insights, 'Progress Tracking', valNotify3, onChangeFunction3),
          ],
        ),
      ),
    );
  }

  Padding buildSwitch(IconData iconOff, IconData iconOn, String title, bool value, Function onChangeMethod) {
    IconData currentIcon = value ? iconOn : iconOff;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(currentIcon),
          Text(title, style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600]
          )),
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

Padding buildColorOption(String title, {bool isPrimary = false, bool isSecondary = false}) {
  Color color;
  if (isPrimary) {
    color = Provider.of<ThemeProvider>(context).primaryColor;
  } else if (isSecondary) {
    color = Provider.of<ThemeProvider>(context).secondaryColor;
  } else {
    color = selectedColor;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => pickColor(context, isPrimary: isPrimary, isSecondary: isSecondary),
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
            color: Colors.grey[600],
          ),
        ),
        Transform.scale(
          scale: 0.7,
          child: IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () => pickColor(context, isPrimary: isPrimary, isSecondary: isSecondary),
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

void pickColor(BuildContext context, {bool isPrimary = false, bool isSecondary = false}) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick color'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildColorPicker(isPrimary: isPrimary, isSecondary: isSecondary),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Select',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget buildColorPicker({bool isPrimary = false, bool isSecondary = false}) {
  Color selectedColor;
  if (isPrimary) {
    selectedColor = Provider.of<ThemeProvider>(context).primaryColor;
  } else if (isSecondary) {
    selectedColor = Provider.of<ThemeProvider>(context).secondaryColor;
  } else {
    selectedColor = this.selectedColor;
  }

  return ColorPicker(
    pickerColor: selectedColor,
    onColorChanged: (color) {
      setState(() {
        if (isPrimary) {
          Provider.of<ThemeProvider>(context, listen: false).setPrimaryColor(color);
        } else if (isSecondary) {
          Provider.of<ThemeProvider>(context, listen: false).setSecondaryColor(color);
        } else {
          selectedColor = color;
        }
      });
    },
    enableAlpha: false,
    labelTypes: const [],
  );
}

}