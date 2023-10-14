import 'package:flutter/material.dart';
import 'package:workout_app/data/hive_database.dart';
import 'package:workout_app/models/setting.dart';

import '../models/constants.dart';

// This class holds all of the various settings, to add more simply add to list
class SettingsData extends ChangeNotifier {
  final db = HiveDatabase();

  // Default values
  List<Setting> settingsList = [
    Setting(name: keyMap[Keys.theme].toString(), isString: false, value: false),
    Setting(name: keyMap[Keys.notifications].toString(), isString: false, value: true),
    Setting(name: keyMap[Keys.progressTracking].toString(), isString: false, value: true),
    Setting(name: keyMap[Keys.remoteData].toString(), isString: false, value: false),
    Setting(name: keyMap[Keys.userName].toString(), isString: false, value: "Real guy"),
  ];

  bool getSwitchValues(String identifier) {
    return getRelevantSetting(identifier).value;
  }

  void initializeSettingsList() {
    if (db.settingsBox.isNotEmpty) {
      settingsList = db.readSettings();
    } else {
      Map<String, Setting> settingsMap = {};
      for (Setting setting in settingsList) {
        settingsMap[setting.name] = setting;
      }
      db.saveSettings(settingsMap);
    }
  }

  Setting getRelevantSetting(String settingName) {
    return settingsList.firstWhere((setting) => setting.name == settingName);
  }

  void editSetting(String settingName, var newValue) {
    Setting relevantSetting = getRelevantSetting(settingName);
    relevantSetting.value = newValue;
    //update DB
    db.saveSetting(settingName, relevantSetting);

    notifyListeners();
  }
}
