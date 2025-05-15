import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/text_divider.dart';
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
    final schedules = await DatabaseHelper.getAll<WorkoutSchedule>();
    setState(() {
      _activeSchedule = schedules.firstWhere(
        (schedule) =>
            schedule.endDate == null ||
            schedule.endDate!.isAfter(DateTime.now()),
        orElse: null,
      );
      _inactiveSchedules =
          schedules.where((schedule) => schedule != _activeSchedule).toList();
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
                ? Card(
                  color: themeProvider.getBackgroundColor(),
                  child: ListTile(
                    title: Text(
                      _activeSchedule!.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.getTextColor(),
                      ),
                    ),
                    subtitle: Text(
                      _activeSchedule!.description ?? 'No description',
                      style: TextStyle(color: themeProvider.getTextColor()),
                    ),
                  ),
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
                          return Card(
                            color: themeProvider.getBackgroundColor(),
                            child: ListTile(
                              title: Text(
                                schedule.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: themeProvider.getTextColor(),
                                ),
                              ),
                              subtitle: Text(
                                schedule.description ?? 'No description',
                                style: TextStyle(
                                  color: themeProvider.getTextColor(),
                                ),
                              ),
                            ),
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
