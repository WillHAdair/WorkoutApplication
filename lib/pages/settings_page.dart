import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/custom_switch.dart';
import 'package:workout_app/components/text_divider.dart';
import 'package:workout_app/utils/settings.dart';
import 'package:workout_app/utils/themes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.getBackgroundColor(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextDivider(text: "Theme", icon: Icons.light_mode),
          //TODO: SAVE STATE FOR DARK MODE
          CustomSwitch(title: "Dark Mode", defaultValue: settingsProvider.isDarkMode, onChangeMethod: (bool newValue) => themeProvider.toggleTheme(context, newValue))
          ],
      ),
    );
  }
}
