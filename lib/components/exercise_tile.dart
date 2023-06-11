import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
    Color tileColor = Colors.grey[100]!;
    Color chipColor = const Color.fromARGB(255, 134, 134, 134);
    if (isCompleted) {
      tileColor = const Color.fromARGB(255, 53, 153, 57);
      chipColor = const Color.fromARGB(255, 39, 117, 42);
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Slidable(
        endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onSettingsPress(),
            backgroundColor: Colors.grey.shade800,
            icon: Icons.settings,
            borderRadius: BorderRadius.circular(12),
          ),
          SlidableAction(
            onPressed: (context) => onDeletePress(),
            backgroundColor: Colors.red.shade300,
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

 


    