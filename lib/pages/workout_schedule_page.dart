import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/text_divider.dart';
import 'package:workout_app/components/workout_schedule_card.dart';
import 'package:workout_app/models/schedule_day.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/models/workout_schedule.dart';
import 'package:workout_app/utils/database_helper.dart';
import 'package:workout_app/utils/themes.dart';

class WorkoutSchedulePage extends StatefulWidget {
  const WorkoutSchedulePage({super.key});

  @override
  State<WorkoutSchedulePage> createState() => _WorkoutSchedulePageState();
}

class _WorkoutSchedulePageState extends State<WorkoutSchedulePage> {
  WorkoutSchedule? _activeSchedule;
  List<WorkoutSchedule> _inactiveSchedules = [];

  @override
  void initState() {
    super.initState();
    _loadSchedules();
  }

  Future<void> _loadSchedules() async {
    // Mock data for testing
    final mockSchedule =
        WorkoutSchedule()
          ..name = 'Test Schedule'
          ..startDate = DateTime.now().subtract(const Duration(days: 5))
          ..isActive = true
          ..days.addAll([
            ScheduleDay()
              ..dayNumber = 1
              ..isRestDay = false
              ..workouts.add(Workout()..name = 'Push-ups'),
            ScheduleDay()
              ..dayNumber = 2
              ..isRestDay = true,
            ScheduleDay()
              ..dayNumber = 3
              ..isRestDay = false
              ..workouts.add(Workout()..name = 'Squats'),
          ]);

    setState(() {
      _activeSchedule = mockSchedule;
      _inactiveSchedules = []; // No inactive schedules for testing
    });
  }

  void _addSchedule() {
    // Navigate to a page or show a dialog to add a new workout schedule
    // For now, just print a placeholder message
    print('Add a new workout schedule');
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.getBackgroundColor(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextDivider(text: 'Active Schedule', icon: Icons.history),
            _activeSchedule != null
                ? WorkoutScheduleCard(
                  schedule: _activeSchedule!,
                  onSettingsPress: () => {},
                  onDeletePress: () => {},
                  onForwardPress: () => {},
                )
                : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'No active schedules',
                      style: TextStyle(
                        fontSize: 16,
                        color: themeProvider.getTextColor(),
                      ),
                    ),
                  ),
                ),
            TextDivider(
              text: 'Inactive Schedules',
              icon: Icons.history_toggle_off,
            ),
            Expanded(
              child:
                  _inactiveSchedules.isNotEmpty
                      ? ListView.builder(
                        itemCount: _inactiveSchedules.length,
                        itemBuilder: (context, index) {
                          final schedule = _inactiveSchedules[index];
                          return WorkoutScheduleCard(
                            schedule: schedule!,
                            onSettingsPress: () => {},
                            onDeletePress: () => {},
                            onForwardPress: () => {},
                          );
                        },
                      )
                      : Center(
                        child: Text(
                          'No inactive schedules',
                          style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.getTextColor(),
                          ),
                        ),
                      ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSchedule,
        backgroundColor: themeProvider.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
