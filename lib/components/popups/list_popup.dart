import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/dropdown/workout_dropdown_list.dart';
import 'package:workout_app/data/theme_provider.dart';
import 'package:workout_app/models/workout.dart';

class ListPopup extends StatelessWidget {
  final void Function(Workout) onChange;
  final VoidCallback onCancel;
  final List<Workout> workouts;
  const ListPopup(
      {super.key,
      required this.onChange,
      required this.onCancel,
      required this.workouts});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            ...workouts.map((workout) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: WorkoutDropdownList(
                  title: workout.name,
                  exercises: workout.exercises,
                  isSelected: false,
                  onChanged: (value) => onChange(workout),
                ),
              );
            })
          ],
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: onCancel,
          child: Text(
            "Cancel",
            style: TextStyle(
                color: Provider.of<ThemeProvider>(context).cancelText),
          ),
        ),
      ],
    );
  }
}
