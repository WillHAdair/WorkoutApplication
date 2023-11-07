import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/pages/Home/default_home_page.dart';
import 'package:workout_app/pages/Home/workout_home_page.dart';
import 'package:workout_app/data/settings_data.dart';
import 'package:workout_app/data/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool workoutStarted = false;
  // ignore: unused_field
  int _currentIndex = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<WorkoutData>(context, listen: false).initializeWorkoutList();
    final settingsData = Provider.of<SettingsData>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    workoutStarted = Provider.of<WorkoutData>(context).isWorkoutStarted();
    bool darkMode = settingsData.getSwitchValues(keyMap[Keys.theme].toString());

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      themeProvider.toggleTheme(darkMode);
    });
  }

  void changeWorkoutStatus(bool newStatus) {
    setState(() {
      workoutStarted = newStatus;
      // Determine the correct index based on the workout status change
      _currentIndex = workoutStarted ? 1 : 0; // Change to the appropriate index
    });
    Provider.of<WorkoutData>(context, listen: false)
        .changeWorkoutStarted(newStatus);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        body: IndexedStack(
          index: Provider.of<WorkoutData>(context).isWorkoutStarted() ? 1 : 0,
          children: [
            DefaultHomePage(
              onWorkoutStatusChange: changeWorkoutStatus,
            ),
            WorkoutHomePage(
              onWorkoutStatusChange: changeWorkoutStatus,
            ),
          ],
        ),
      ),
    );
  }
}
