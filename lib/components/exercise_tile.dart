import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../data/theme_provider.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String sets;
  final String reps;
  final bool isCompleted;
  final VoidCallback onSettingsPress;
  final VoidCallback onDeletePress;
  final void Function(bool?)? onChanged;

  const ExerciseTile({
    Key? key,
    required this.exerciseName,
    required this.weight,
    required this.sets,
    required this.reps,
    required this.isCompleted,
    required this.onChanged,
    required this.onSettingsPress,
    required this.onDeletePress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color tileColor = Provider.of<ThemeProvider>(context).getTileColor();
    Color chipColor = Provider.of<ThemeProvider>(context).getChipcolor();
    if (isCompleted) {
      tileColor = Provider.of<ThemeProvider>(context).tileCompleted;
      chipColor = Provider.of<ThemeProvider>(context).chipCompleted;
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => onSettingsPress(),
              backgroundColor: Provider.of<ThemeProvider>(context).settingsTile,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: (context) => onDeletePress(),
              backgroundColor: Provider.of<ThemeProvider>(context).deleteTile,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: tileColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            title: Text(exerciseName),
            subtitle: Row(
              children: [
                Chip(
                  label: Text("$weight lb"),
                  backgroundColor: chipColor,
                ),
                Chip(
                  label: Text("$sets sets"),
                  backgroundColor: chipColor,
                ),
                Chip(
                  label: Text("$reps reps"),
                  backgroundColor: chipColor,
                ),
              ],
            ),
            trailing: Checkbox(
              value: isCompleted,
              onChanged: (value) => onChanged!(value),
            ),
          ),
        ),
      ),
    );
  }
}
