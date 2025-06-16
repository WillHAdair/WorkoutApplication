import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/pages/add_edit_schedule_page.dart';
import 'package:workout_app/components/text_divider.dart';
import 'package:workout_app/components/workout_schedule_card.dart';
import 'package:workout_app/models/schedule_day.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/models/workout_schedule.dart';
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

  Future<void> _loadSchedules() async {    // Mock data for testing
    final mockSchedule = WorkoutSchedule(
      id: 1,
      name: 'Test Schedule',
      startDate: DateTime.now().subtract(const Duration(days: 2)),
      isActive: true,
      days: [
        ScheduleDay(id: 1, name: 'Rest', workouts: List.empty()),
        ScheduleDay(id: 2, name: 'Chest Day', workouts: [
          Workout(id: 1, name: 'Bench Press', exercises: []),
          Workout(id: 2, name: 'Incline Dumbbell Press', exercises: []),
        ]),
        ScheduleDay(id: 3, name: "Back Day", workouts: [
          Workout(id: 1, name: 'Bench Press', exercises: []),
          Workout(id: 2, name: 'Incline Dumbbell Press', exercises: []),
        ]),
      ],
    );

    setState(() {
      _activeSchedule = mockSchedule;
      _inactiveSchedules = []; // No inactive schedules for testing
    });
  }
  void _addSchedule() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddEditSchedulePage(),
      ),
    );
    if (result is WorkoutSchedule) {
      setState(() {
        _activeSchedule = result;
      });
    }
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
                )
                : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 69),
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
                            schedule: schedule,
                            onSettingsPress: () => {},
                            onDeletePress: () => {},
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
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
