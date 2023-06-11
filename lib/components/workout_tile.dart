import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WorkoutTile extends StatelessWidget {
  final String workoutName;
  final VoidCallback onForwardPress;
  final VoidCallback onSettingsPress;
  final VoidCallback onDeletePress;

  const WorkoutTile({
    Key? key,
    required this.workoutName,
    required this.onForwardPress,
    required this.onSettingsPress,
    required this.onDeletePress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: SizedBox(
              height: 40,
              child: Image.asset('lib/images/dumbell.png'),
            ),
            title: Text(
              workoutName,
              style: const TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: onForwardPress,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
