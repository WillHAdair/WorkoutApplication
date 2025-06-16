import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/models/workout.dart';
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

    // Get the first exercise name for display, or show "No exercises"
    final String firstExerciseName =
        workout.exercises.isNotEmpty
            ? workout.exercises.first.name
            : 'No exercises';

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
              final double exerciseTop = iconTop + iconSize / 2 - 12;

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
                  // Icon (below title, left-aligned)
                  Positioned(
                    left: 0,
                    top: iconTop,
                    child: Icon(
                      Icons.fitness_center_rounded,
                      size: iconSize,
                      color: themeProvider.getTextColor(),
                    ),
                  ),
                  // Exercise text (vertically centered to icon)
                  Positioned(
                    left: iconSize + 16,
                    top: exerciseTop,
                    right: 56,
                    child: Text(
                      firstExerciseName,
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
