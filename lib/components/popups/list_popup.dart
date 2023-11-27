import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/basic_widgets/text_divider.dart';
import 'package:workout_app/components/dropdown/workout_dropdown_list.dart';
import 'package:workout_app/data/theme_provider.dart';
import 'package:workout_app/models/workout.dart';

// ignore: must_be_immutable
class ListPopup extends StatelessWidget {
  final void Function(Workout) onChange;
  final VoidCallback onCancel;
  final List<Workout> workouts;
  final String errorMessage;
  Workout? preferred;
  Map<String, IconData>? heading;

  ListPopup({
    super.key,
    required this.onChange,
    required this.onCancel,
    required this.workouts,
    required this.errorMessage,
    this.preferred,
    this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      content: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (preferred != null)
            Column(
              children: [
                TextDivider(
                  text: heading!.keys.first,
                  icon: heading!.values.first,
                ),
                WorkoutDropdownList(
                  title: preferred!.name,
                  exercises: preferred!.exercises,
                  isSelected: false,
                  onChanged: (value) => onChange(preferred!),
                ),
                TextDivider(
                  text: heading!.keys.last,
                  icon: heading!.values.last,
                ),
              ],
            ),
          if (workouts.isNotEmpty)
            ListBody(
              children: workouts
                  .map(
                    (workout) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: WorkoutDropdownList(
                        title: workout.name,
                        exercises: workout.exercises,
                        isSelected: false,
                        onChanged: (value) => onChange(workout),
                      ),
                    ),
                  )
                  .toList(),
            ),
          if (workouts.isEmpty) Text(errorMessage),
        ],
      ),
      ),
      actions: [
        MaterialButton(
          onPressed: onCancel,
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).cancelText,
            ),
          ),
        ),
      ],
    );
  }
}
