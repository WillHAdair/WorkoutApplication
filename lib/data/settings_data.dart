import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/data/hive_database.dart';
import 'package:workout_app/data/theme_provider.dart';
import 'package:workout_app/models/setting.dart';

import '../models/constants.dart';

// This class holds all of the various settings, to add more simply add to list
class SettingsData extends ChangeNotifier {
  final db = HiveDatabase();

  // Default values
  List<Setting> settingsList = [
    Setting(
        name: "Primary",
        type: SettingType.color,
        value: const Color.fromRGBO(76, 175, 80, 1)),
    Setting(
        name: "Secondary",
        type: SettingType.color,
        value: const Color.fromRGBO(76, 175, 80, 1)),
    Setting(
        name: "SkipDay",
        type: SettingType.color,
        value: const Color.fromRGBO(38, 198, 218, 1)),
    Setting(
        name: "RestDay",
        type: SettingType.color,
        value: const Color.fromRGBO(229, 115, 115, 1)),
    Setting(
        name: "RepCounter",
        type: SettingType.materialColor,
        value: Colors.green),
    Setting(name: "IsDarkMode", type: SettingType.boolean, value: false),
    Setting(name: "Notifications", type: SettingType.boolean, value: true),
    Setting(name: "ProgressTracking", type: SettingType.boolean, value: true),
    Setting(name: "UserName", type: SettingType.string, value: "Real guy"),
  ];

  bool getBooleanValue(String identifier) {
    switch (identifier.toLowerCase()) {
      case "theme":
        return getRelevantSetting("IsDarkMode").value as bool;
      case "notifications":
        return getRelevantSetting("Notifications").value as bool;
      case "tracking":
        return getRelevantSetting("ProgressTracking").value as bool;
      default:
        return false;
    }
  }

  void initializeSettingsList() {
    if (db.selectedKeyFound("SETTINGS")) {
      settingsList = db.readSettings();
    } else {
      db.saveSettings(settingsList);
    }
  }

  Setting getRelevantSetting(String settingName) {
    return settingsList.firstWhere((setting) => setting.name == settingName);
  }

  void editSetting(String settingName, var newValue) {
    Setting relevantSetting = getRelevantSetting(settingName);
    relevantSetting.value = newValue;
    //update DB
    db.saveSettings(settingsList);

    notifyListeners();
  }
}
