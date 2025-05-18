import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/models/schedule_day.dart';
import 'package:workout_app/models/workout_schedule.dart';
import 'package:workout_app/utils/themes.dart';

class WorkoutScheduleCard extends StatefulWidget {
  final WorkoutSchedule schedule;
  final VoidCallback onSettingsPress;
  final VoidCallback onDeletePress;
  final VoidCallback? onChanged;

  const WorkoutScheduleCard({
    super.key,
    required this.schedule,
    required this.onSettingsPress,
    required this.onDeletePress,
    this.onChanged,
  });

  @override
  State<WorkoutScheduleCard> createState() => _WorkoutScheduleCardState();
}

class _WorkoutScheduleCardState extends State<WorkoutScheduleCard> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final String scheduleName = widget.schedule.name;
    final int daysSinceStart =
        DateTime.now().difference(widget.schedule.startDate).inDays;

    final int todayIndex = daysSinceStart % widget.schedule.days.length;
    final ScheduleDay? todayScheduleDay =
        widget.schedule.days.isNotEmpty
            ? widget.schedule.days[todayIndex]
            : null;

    final String todayWorkout =
        todayScheduleDay == null
            ? 'No schedule for today'
            : todayScheduleDay.workouts.isEmpty
            ? 'Rest Day'
            : todayScheduleDay.workouts.isNotEmpty
            ? todayScheduleDay.workouts.first.name
            : 'No workouts planned';

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => widget.onDeletePress(),
              backgroundColor: Colors.red.shade500,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          decoration: BoxDecoration(
            color: themeProvider.getButtonBackground(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const SizedBox.shrink(),
            title: Text(
              todayWorkout,
              style: TextStyle(color: themeProvider.getTextColor()),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: widget.onSettingsPress,
              color: themeProvider.getTextColor(),
            ),
          ),
        ),
      ),
    );
  }
}
