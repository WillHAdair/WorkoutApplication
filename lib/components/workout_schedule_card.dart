
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:workout_app/models/schedule_day.dart';
import 'package:workout_app/models/workout_schedule.dart';

class WorkoutScheduleCard extends StatefulWidget {
  final WorkoutSchedule schedule;
  final VoidCallback onForwardPress;
  final VoidCallback onSettingsPress;
  final VoidCallback onDeletePress;
  final VoidCallback? onChanged;
  bool? isSelected;

  WorkoutScheduleCard({
    super.key,
    required this.schedule,
    required this.onForwardPress,
    required this.onSettingsPress,
    required this.onDeletePress,
    this.isSelected,
    this.onChanged,
  });

  @override
  State<WorkoutScheduleCard> createState() => _WorkoutScheduleCardState();
}

class _WorkoutScheduleCardState extends State<WorkoutScheduleCard> {
  @override
  Widget build(BuildContext context) {
    final String scheduleName = widget.schedule.name;
    final int daysSinceStart = DateTime.now().difference(widget.schedule.startDate).inDays;

    final ScheduleDay? todayScheduleDay = widget.schedule.days
        .where((day) => day.dayNumber == (daysSinceStart % widget.schedule.days.length) + 1)
        .firstOrNull;

    final String todayWorkout = todayScheduleDay == null
        ? 'No schedule for today'
        : todayScheduleDay.isRestDay
            ? 'Rest Day'
            : todayScheduleDay.workouts.isNotEmpty
                ? todayScheduleDay.workouts.first.name
                : 'No workouts planned';    

    return Padding(
      padding: const EdgeInsets.all(14),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => widget.onSettingsPress(),
              backgroundColor: Colors.grey.shade800,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: (context) => widget.onDeletePress(),
              backgroundColor: Colors.red.shade500,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: widget.onChanged != null
                    ? Checkbox(
                        value: widget.isSelected!,
                        onChanged: (value) {
                          widget.onChanged!();
                          setState(() {
                            widget.isSelected = value!;
                          });
                        },
                      )
                    : const SizedBox.shrink(),
            title: Text(
              todayWorkout,
              style: const TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: widget.onForwardPress,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
