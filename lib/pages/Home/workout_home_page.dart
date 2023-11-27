import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:workout_app/components/basic_widgets/text_divider.dart';
import 'package:workout_app/components/dropdown/exercise_dropdown_list.dart';
import 'package:workout_app/data/theme_provider.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/models/workout_set.dart';

class WorkoutHomePage extends StatefulWidget {
  final void Function(bool) onWorkoutStatusChange;
  const WorkoutHomePage({Key? key, required this.onWorkoutStatusChange})
      : super(key: key);

  @override
  WorkoutHomePageState createState() => WorkoutHomePageState();
}

class WorkoutHomePageState extends State<WorkoutHomePage> {
  void onCheckBoxChanged(String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkOffExercise(chosen.name, exerciseName);
  }

  Workout chosen = restWorkout;
  late Timer _timer;
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;
  // ignore: unused_field
  bool _timerRunning = false;
  ValueNotifier<double> valueNotifier = ValueNotifier<double>(0);
  List<WorkoutSet> sets = [
    WorkoutSet(reps: "10", weight: "95", isCompleted: true),
    WorkoutSet(reps: "10", weight: "135", isCompleted: false),
    WorkoutSet(reps: "10", weight: "205", isCompleted: false)
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void startWorkoutTimer() {
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        if (_seconds % 60 == 0) {
          _minutes++;
          _seconds = 0;
        }
        if (_minutes > 0 && _minutes % 60 == 0) {
          _hours++;
          _minutes = 0;
        }
        valueNotifier.value = (_seconds / 60) * 100;
      });
    });
    _timerRunning = true;
  }

  void _stopTimer() {
    _timer.cancel();
    setState(() {
      _timerRunning = false;
    });
  }

  void endWorkout() {
    widget.onWorkoutStatusChange(false);
    _stopTimer();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      chosen = Provider.of<WorkoutData>(context).getStartedWorkout()!;
    });
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(chosen.name),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                width: 200,
                height: 200,
                child: SimpleCircularProgressBar(
                  valueNotifier: valueNotifier,
                  size: 200,
                  progressStrokeWidth: 5,
                  backStrokeWidth: 5,
                  onGetText: (double value) {
                    TextStyle centerTextStyle = const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    );
                    return Text(
                      _formatTime(_hours, _minutes, _seconds),
                      style: centerTextStyle,
                    );
                  },
                ),
              ),
            ),
            const TextDivider(
                text: 'Current Exercise', icon: Icons.fitness_center),
            value.getFirstUnchecked(chosen) != standIn
                ? ExerciseDropdownList(
                    title: value.getFirstUnchecked(chosen).name,
                    sets: value.getFirstUnchecked(chosen).sets,
                    onChanged: () {
                      onCheckBoxChanged(value.getFirstUnchecked(chosen).name);
                    },
                    isCompleted: false)
                : const SizedBox.shrink(),
            const TextDivider(text: 'Next Exercises', icon: Icons.checklist),
            ListView.builder(
              itemCount: value.getUncheckedExercises(chosen).length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) => ExerciseDropdownList(
                  title: value.getUncheckedExercises(chosen)[index].name,
                  sets: value.getUncheckedExercises(chosen)[index].sets,
                  isCompleted: false,
                  onChanged: () {
                    onCheckBoxChanged(
                        value.getUncheckedExercises(chosen)[index].name);
                  }),
            ),
            const TextDivider(text: 'Completed Exercises', icon: Icons.done),
            ListView.builder(
              itemCount: value.getCheckedExercises(chosen).length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) => ExerciseDropdownList(
                  title: value.getCheckedExercises(chosen)[index].name,
                  sets: value.getCheckedExercises(chosen)[index].sets,
                  isCompleted: true,
                  onChanged: () {
                    onCheckBoxChanged(
                        value.getCheckedExercises(chosen)[index].name);
                  }),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(22),
          child: TextButton(
              onPressed: () => endWorkout(),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor:
                    Provider.of<ThemeProvider>(context).rejectColor,
                foregroundColor: Colors.red[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.close),
                  Text(
                    'End Workout',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  String _formatTime(int hours, int minutes, int seconds) {
    if (hours == 0 && minutes == 0) {
      return '00:${_formatTwoDigit(seconds)}';
    }
    if (hours == 0) {
      return '${_formatTwoDigit(minutes)}:${_formatTwoDigit(seconds)}';
    }
    return '$hours:${_formatTwoDigit(minutes)}:${_formatTwoDigit(seconds)}';
  }

  String _formatTwoDigit(int number) {
    return number.toString().padLeft(2, '0');
  }
}
