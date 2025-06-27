import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/utils/themes.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final VoidCallback onEditPress;
  final VoidCallback onDeletePress;

  const WorkoutCard({
    super.key,
    required this.workout,
    required this.onEditPress,
    required this.onDeletePress,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Determine image icon and description based on workout type
    ImageIcons workoutImageIcon;
    String workoutDescription;

    if (workout is ExercisesWorkout) {
      // Use your exercises workout image icon
      workoutImageIcon = ImageIcons.dumbell; // Replace with your actual enum value
      workoutDescription = workout.description ?? 'No description';
    } else if (workout is TimedWorkout) {
      // Use your timed workout image icon
      workoutImageIcon = ImageIcons.timed; // Replace with your actual enum value
      final timedWorkout = workout as TimedWorkout;

      // Format duration
      final minutes = timedWorkout.duration ~/ 60;
      final seconds = timedWorkout.duration % 60;
      final durationText = '${minutes}:${seconds.toString().padLeft(2, '0')}';

      // Create description with duration and optional weight
      String description = 'Duration: $durationText';
      if (timedWorkout.weight != null && timedWorkout.weight! > 0) {
        description += ' • Weight: ${timedWorkout.weight!.toStringAsFixed(1)} lbs';
      }

      workoutDescription = workout.description?.isNotEmpty == true
          ? workout.description!  // Use provided description if available
          : description;
    } else {
      // Fallback image icon
      workoutImageIcon = ImageIcons.dumbell; // Replace with your default enum value
      workoutDescription = workout.description ?? 'Unknown workout type';
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
              final double descriptionTop = iconTop + iconSize / 2 - 12;

              return Stack(
                children: [
                  // Title (top left, full width)
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 56,
                    child: Text(
                      workout.name,
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
                  // Description text (vertically centered to icon)
                  Positioned(
                    left: iconSize + 16,
                    top: descriptionTop,
                    right: 56,
                    child: Text(
                      workoutDescription,
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
                      onPressed: onEditPress,
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
