import 'package:flutter/material.dart';
import 'package:workout_app/models/exercise.dart';

class ExerciseDialog extends StatefulWidget {
  final Exercise exercise;
  const ExerciseDialog({
    Key? key,
    required this.exercise,
  }) : super(key: key);
  @override
  State<ExerciseDialog> createState() => _ExerciseDialogState();
}

class _ExerciseDialogState extends State<ExerciseDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
