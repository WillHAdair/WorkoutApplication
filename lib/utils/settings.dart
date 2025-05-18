import 'package:flutter/material.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/storage/settings.dart';
import 'package:workout_app/utils/database_helper.dart';

class SettingsProvider extends ChangeNotifier {
  bool isDarkMode = false;
  bool showLast30Days = false;
  ActivityTracker selectedOption = ActivityTracker.workoutsCompleted;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> init() async {
    final settings = await DatabaseHelper.getById<Settings>(1);
    if (settings != null) {
      isDarkMode = settings.isDarkMode;
      showLast30Days = settings.showLast30Days;
      selectedOption = settings.selectedOption;
    } else {
      final defaultSettings = Settings()
        ..id = 1
        ..isDarkMode = isDarkMode
        ..showLast30Days = showLast30Days
        ..selectedOption = selectedOption;
      await DatabaseHelper.add<Settings>(defaultSettings);
    }
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> updateSettings({
    required bool isDarkMode,
    required bool showLast30Days,
    required ActivityTracker selectedOption,
  }) async {
    this.isDarkMode = isDarkMode;
    this.showLast30Days = showLast30Days;
    this.selectedOption = selectedOption;

    final settings = Settings()
      ..id = 1
      ..isDarkMode = isDarkMode
      ..showLast30Days = showLast30Days
      ..selectedOption = selectedOption;

    await DatabaseHelper.update<Settings>(settings);
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    isDarkMode = value;
    final settings = Settings()
      ..id = 1
      ..isDarkMode = isDarkMode
      ..showLast30Days = showLast30Days
      ..selectedOption = selectedOption;
    await DatabaseHelper.update<Settings>(settings);
    notifyListeners();
  }

  Future<void> setShowLast30Days(bool value) async {
    showLast30Days = value;
    final settings = Settings()
      ..id = 1
      ..isDarkMode = isDarkMode
      ..showLast30Days = showLast30Days
      ..selectedOption = selectedOption;
    await DatabaseHelper.update<Settings>(settings);
    notifyListeners();
  }

  Future<void> setSelectedOption(ActivityTracker value) async {
    selectedOption = value;
    final settings = Settings()
      ..id = 1
      ..isDarkMode = isDarkMode
      ..showLast30Days = showLast30Days
      ..selectedOption = selectedOption;
    await DatabaseHelper.update<Settings>(settings);
    notifyListeners();
  }
}