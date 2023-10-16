import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/custom_tile.dart';
import 'package:workout_app/components/dropdown/workout_dropdown_list.dart';
import 'package:workout_app/components/option_tile.dart';
import 'package:workout_app/components/sliding_tile.dart';
import 'package:workout_app/data/theme_provider.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/models/tracker.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/pages/Workouts/workout_page.dart';

class SchedulePage extends StatefulWidget {
  final Tracker tracker;

  const SchedulePage({super.key, required this.tracker});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final nameController = TextEditingController();
  Workout restDay = Workout(name: "break", exercises: []);
  double sliderValue = 0;
  List<bool> areWorkoutsChosen = [false, false, false, false, false, false, false, false, false, false];
  List<Workout> workouts = [
    Workout(name: "break", exercises: []), 
    Workout(name: "break", exercises: []),
    Workout(name: "break", exercises: []),
    Workout(name: "break", exercises: []),
    Workout(name: "break", exercises: []),
    Workout(name: "break", exercises: []),
    Workout(name: "break", exercises: []),
    Workout(name: "break", exercises: []),
    Workout(name: "break", exercises: []),
    Workout(name: "break", exercises: [])
  ];

  void navigateToWorkout(Workout workout) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WorkoutPage(
                  workoutName: workout.name,
                )));
  }

  void onCancel() {
    Navigator.pop(context);
  }

  void onChanged(Workout workout, int index) {
    setState(() {
      areWorkoutsChosen[index] = true;
      workouts[index] = workout;
    });
    Navigator.pop(context);
  }

  void chooseWorkout (int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ...Provider.of<WorkoutData>(context).getWorkoutList().map((workout) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: WorkoutDropdownList(
                      title: workout.name,
                      exercises: workout.exercises,
                      isSelected: false,
                      onChanged: (value) => onChanged(workout, index),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
      appBar: AppBar(
        title: Text(widget.tracker.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(
                  Icons.edit_calendar,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text('Schedule Data',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            Row(
              children: [
                const Text('Schedule name: '),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter schedule name',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('Unique Days: $sliderValue'),
                Expanded(
                  child: Slider(
                    value: sliderValue,
                    min: 0,
                    max: 10,
                    divisions: 10,
                    onChanged: (value) {
                      setState(() {
                        sliderValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text('Planned workouts',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sliderValue.toInt(),
              itemBuilder: (context, index) => areWorkoutsChosen[index] ?  CustomTile(
                text: workouts[index].name,
                onForwardPress: () => navigateToWorkout(workouts[index]),
              ) : OptionTile(
                onClick: () => chooseWorkout(index)
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
