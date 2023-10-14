import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:workout_app/components/dropdown_list.dart';

class WorkoutHomePage extends StatefulWidget {
  const WorkoutHomePage({Key? key}) : super(key: key);

  @override
  WorkoutHomePageState createState() => WorkoutHomePageState();
}

class WorkoutHomePageState extends State<WorkoutHomePage> {
  late Timer _timer;
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;
  bool _timerRunning = true;
  ValueNotifier<double> valueNotifier = ValueNotifier<double>(0);
  List<SetData> sets = [SetData(reps: 10, weight: 95), 
                        SetData(reps: 10, weight: 135),
                        SetData(reps: 10, weight: 205)];

  @override
  void initState() {
    super.initState();
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
  }

  void endWorkout(String workoutName) {
    // TODO: implement method to end workout
    _stopTimer();
  }

  void _stopTimer() {
    _timer.cancel();
    setState(() {
      _timerRunning = false;
    });
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
        const SizedBox(height: 15),
        DropdownList(title: 'Benchpress', sets: sets, isCompleted: false),
        Padding(
          padding: const EdgeInsets.all(22),
          child: TextButton(
          onPressed: () => endWorkout('Chest Day'),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: Colors.red,
              foregroundColor: Colors.red[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'End Workout',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
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
