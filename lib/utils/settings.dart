import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _showLast30Days = false;
  String _selectedOption = 'Workouts Completed';

  bool get showLast30Days => _showLast30Days;
  String get selectedOption => _selectedOption;

  SettingsProvider() {
    _loadPreferences(); // Load saved preferences when the provider is initialized
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _showLast30Days = prefs.getBool('showLast30Days') ?? false;
    _selectedOption = prefs.getString('selectedOption') ?? 'Workouts Completed';
    notifyListeners(); // Notify listeners after loading preferences
  }

  Future<void> setShowLast30Days(bool value) async {
    _showLast30Days = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showLast30Days', value);
    notifyListeners(); // Notify listeners of the change
  }

  Future<void> setSelectedOption(String value) async {
    _selectedOption = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedOption', value);
    notifyListeners(); // Notify listeners of the change
  }
}