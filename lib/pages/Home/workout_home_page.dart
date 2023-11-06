import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:workout_app/components/dropdown/exercise_dropdown_list.dart';
import 'package:workout_app/data/theme_provider.dart';
import 'package:workout_app/models/workout_set.dart';

class WorkoutHomePage extends StatefulWidget {
  final Function(bool) onWorkoutStatusChange;
  const WorkoutHomePage({Key? key, required this.onWorkoutStatusChange})
      : super(key: key);

  @override
  WorkoutHomePageState createState() => WorkoutHomePageState();
}

class WorkoutHomePageState extends State<WorkoutHomePage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chest Day'),
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
          const SizedBox(height: 10),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Icon(
                Icons.fitness_center,
                color: Colors.blue,
              ),
              SizedBox(width: 10),
              Text('Current exercise',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
            ],
          ),
          ExerciseDropdownList(
              title: 'Benchpress',
              sets: sets,
              onSettingsPress: () => {},
              onDeletePress: () => {},
              onChanged: (p0) => {},
              isCompleted: false),
          const SizedBox(height: 10),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Icon(
                Icons.checklist,
                color: Colors.blue,
              ),
              SizedBox(width: 10),
              Text('Next Exercises',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
            ],
          ),
          ExerciseDropdownList(
              title: 'Incline Bench',
              sets: sets,
              onSettingsPress: () => {},
              onDeletePress: () => {},
              onChanged: (p0) => {},
              isCompleted: false),
          ExerciseDropdownList(
              title: 'Decline Bench',
              sets: sets,
              onSettingsPress: () => {},
              onDeletePress: () => {},
              onChanged: (p0) => {},
              isCompleted: false),
          const SizedBox(height: 10),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Icon(
                Icons.done_all,
                color: Colors.blue,
              ),
              SizedBox(width: 10),
              Text('Completed Exercises',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
            ],
          ),
          ExerciseDropdownList(
              title: 'Chest Flys',
              sets: sets,
              onSettingsPress: () => {},
              onDeletePress: () => {},
              onChanged: (p0) => {},
              isCompleted: false),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(22),
        child: TextButton(
            onPressed: () => endWorkout(),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: Provider.of<ThemeProvider>(context).rejectColor,
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
