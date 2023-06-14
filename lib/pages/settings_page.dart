import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/theme/theme_provider.dart';

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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              ),
              onPressed: () => pickColor(context),
              child: const Text(
                'Pick Color',
                style: TextStyle(fontSize: 24), 
              ),
            ),

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

  void pickColor(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Pick color'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildColorPicker(),
          TextButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: const Text(
              'Select',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    ),
  );

  Widget buildColorPicker() => ColorPicker(
    pickerColor: selectedColor,
    onColorChanged: (color) => setState(() => selectedColor = color),
    enableAlpha: false,
    labelTypes: const [],
  );
}