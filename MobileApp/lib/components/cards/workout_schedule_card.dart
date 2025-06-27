import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/schedule_day.dart';
import 'package:workout_app/models/workout_schedule.dart';
import 'package:workout_app/pages/add_edit_schedule_page.dart';
import 'package:workout_app/utils/themes.dart';

class WorkoutScheduleCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final int daysSinceStart =
        DateTime.now().difference(schedule.startDate).inDays;

    final int todayIndex = schedule.days.isNotEmpty
        ? daysSinceStart % schedule.days.length
        : 0;
    final ScheduleDay? todayScheduleDay =
        schedule.days.isNotEmpty
            ? schedule.days[todayIndex]
            : null;

    final String todayWorkout =
        todayScheduleDay == null
            ? 'No schedule for today'
            : todayScheduleDay.workouts.isEmpty
                ? 'Rest Day'
                : todayScheduleDay.workouts.first.name;

    ImageIcons workoutImageIcon;
    if (todayWorkout == 'Rest Day') {
      workoutImageIcon = ImageIcons.bed;
    } else if (todayWorkout == 'No schedule for today') {
      workoutImageIcon = ImageIcons.calendar;
    } else {
      workoutImageIcon = ImageIcons.dumbell;
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => onDeletePress(),
              backgroundColor: themeProvider.rejectColor,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          height: 140,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: themeProvider.getButtonBackground(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              const double iconSize = 44.0;
              const double iconTop = 48.0;
              final double workoutTop = iconTop + iconSize / 2 - 12;

              return Stack(
                children: [
                  // Title (top left, full width)
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 56,
                    child: Text(
                      schedule.name,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.getTextColor(),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Custom Image Icon (below title, left-aligned)
                  Positioned(
                    left: 0,
                    top: iconTop,
                    child: SizedBox(
                      height: iconSize,
                      width: iconSize,
                      child: Image.asset(
                        imageIconPaths[workoutImageIcon]!,
                        height: iconSize,
                        width: iconSize,
                        fit: BoxFit.contain,
                        // Optional: Add color filter to match theme
                        color: themeProvider.getTextColor(),
                        colorBlendMode: BlendMode.srcIn,
                      ),
                    ),
                  ),
                  // Workout text (vertically centered to icon)
                  Positioned(
                    left: iconSize + 16,
                    top: workoutTop,
                    right: 56,
                    child: Text(
                      todayWorkout,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: themeProvider.getTextColor(),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Edit icon button (far right, vertically centered)
                  Positioned(
                    right: 0,
                    top: (constraints.maxHeight - 36) / 2,
                    child: IconButton(
                      icon: const Icon(Icons.edit, size: 36.0),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      color: themeProvider.getTextColor(),
                      onPressed: () async {
                        final result = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddEditSchedulePage(schedule: schedule),
                          ),
                        );
                        if (result is WorkoutSchedule && onChanged != null) {
                          onChanged!();
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
