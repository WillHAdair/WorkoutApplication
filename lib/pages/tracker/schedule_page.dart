import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/basic_widgets/custom_textfield.dart';
import 'package:workout_app/components/basic_widgets/text_divider.dart';
import 'package:workout_app/components/popups/list_popup.dart';
import 'package:workout_app/components/tiles/text_tile.dart';
import 'package:workout_app/components/tiles/sliding_tile.dart';
import 'package:workout_app/data/schedule_data.dart';
import 'package:workout_app/data/theme_provider.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/schedule.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/pages/Workouts/workout_page.dart';

class SchedulePage extends StatefulWidget {
  final Schedule tracker;

  const SchedulePage({super.key, required this.tracker});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final nameController = TextEditingController();
  Workout restDay = Workout(name: "break", exercises: []);
  double sliderValue = 0;
  List<bool> areWorkoutsChosen = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<Workout> workouts = [
    restWorkout,
    restWorkout,
    restWorkout,
    restWorkout,
    restWorkout,
    restWorkout,
    restWorkout,
    restWorkout,
    restWorkout,
    restWorkout,
  ];

  @override
  void initState() {
    super.initState();
    nameController.text = widget.tracker.name;
    sliderValue = widget.tracker.workouts.length.toDouble();
    for (int i = 0; i < widget.tracker.workouts.length; i++) {
      areWorkoutsChosen[i] = true;
      workouts[i] = widget.tracker.workouts[i];
    }
  }

  void navigateToWorkout(Workout workout) {
    if (workout.name != "break") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutPage(
            workoutName: workout.name,
          ),
        ),
      );
    }
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

  void chooseWorkout(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return ListPopup(
          onChange: (workout) => onChanged(workout, index),
          onCancel: onCancel,
          workouts: Provider.of<WorkoutData>(context).getWorkoutList(),
          errorMessage: 'No workouts available');
      },
    );
  }

  void deleteWorkout(int index) {
    setState(() {
      areWorkoutsChosen[index] = false;
      workouts[index] = Workout(name: "break", exercises: []);
    });
  }

  void editTracker() {
    List<Workout> newWorkouts = [];
    for (int i = 0; areWorkoutsChosen[i]; i++) {
      newWorkouts.add(workouts[i]);
    }
    Provider.of<ScheduleData>(context, listen: false)
        .editSchedule(widget.tracker.name, 0, newWorkouts, false);
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
              const TextDivider(text: 'Schedule Data', icon: Icons.edit_calendar),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Schedule name: ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      controller: nameController,
                      name: 'Name',
                      prefixIcon: Icons.calendar_today,
                      inputType: TextInputType.text,
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
              const TextDivider(text: 'Planned Workouts', icon: Icons.schedule),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sliderValue.toInt(),
                itemBuilder: (context, index) => areWorkoutsChosen[index]
                    ? SlidingTile(
                        text: workouts[index].name,
                        onForwardPress: () =>
                            navigateToWorkout(workouts[index]),
                        onSettingsPress: () => chooseWorkout(index),
                        onDeletePress: () => deleteWorkout(index),
                      )
                    : TextTile(
                        contents: defaultTile,
                        onClick: () => chooseWorkout(index),
                        isSlideable: false),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(22),
          child: TextButton(
              onPressed: () => editTracker(),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor:
                    Provider.of<ThemeProvider>(context).acceptColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit_note,
                    color: Colors.white,
                  ),
                  Text(
                    'Edit Tracker',
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
}

const Row defaultTile = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Icon(
      Icons.add,
      size: 30,
    ),
    Text(
      'Choose workout',
      style: TextStyle(
        fontSize: 24,
      ),
    ),
  ],
);
