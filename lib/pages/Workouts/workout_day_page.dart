import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/basic_widgets/custom_textfield.dart';
import 'package:workout_app/components/dropdown/workout_dropdown_list.dart';
import 'package:workout_app/components/popups/customizable_dialog.dart';
import 'package:workout_app/components/sliding_tile.dart';
import 'package:workout_app/data/theme_provider.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/pages/Workouts/workout_page.dart';

class WorkoutDayPage extends StatefulWidget {
  final DateTime date;

  const WorkoutDayPage({super.key, required this.date});

  @override
  State<WorkoutDayPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutDayPage> {
  final workoutNameController = TextEditingController();
  Set<Workout> selectedWorkouts = {};
  void deleteWorkoutFromDay(Workout workout) {
    // TODO: Stub
  }

  void onChanged(Workout workout, bool value) {
    selectedWorkouts.add(workout);
  }

  void onSave() {
    List<Workout> daysWorkouts = Provider.of<WorkoutData>(context, listen: false).getWorkoutsForDay(widget.date);
    daysWorkouts.addAll(selectedWorkouts);
    Provider.of<WorkoutData>(context, listen: false).addWorkoutsToDay(widget.date, daysWorkouts);
    Navigator.pop(context);
  }

  void onCancel() {
    Navigator.pop(context);
  }

  void addWorkoutToDay() {
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
                      onChanged: (value) => onChanged(workout, value!),
                    ),
                  );
                })
              ],
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: onSave,
              child: Text(
                "Select",
                style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).acceptText),
              ),
            ),
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

    void goToWorkoutPage(String workoutName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WorkoutPage(
                  workoutName: workoutName,
                )));
  }

  void edit(String oldWorkoutName) {
    String newWorkoutName = workoutNameController.text;
    Provider.of<WorkoutData>(context, listen: false)
        .changeWorkoutName(oldWorkoutName, newWorkoutName);
    Navigator.pop(context);
    onCancel();
  }

  void onSettingsPress(String workoutName) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomizableDialog(customTextFields: [
          CustomTextField(
              controller: workoutNameController,
              hintText: "New Name",
              obscureText: false)
        ], onSave: () => edit(workoutName), onCancel: onCancel);
      },
    );
  }

  void delete(String workoutName) {
    Provider.of<WorkoutData>(context, listen: false).deleteWorkoutFromDay(widget.date, workoutName);
    Navigator.pop(context);
  }

  void onDeletePress(String workoutName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16),
          backgroundColor: Colors.grey[900],
          content: SingleChildScrollView(
            child: Row(
              children: [
                const Text(
                  'Are you sure?',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 12),
                Flexible(
                  fit: FlexFit.loose,
                  child: MaterialButton(
                    onPressed: () => delete(workoutName),
                    color: Colors.red.shade300,
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  fit: FlexFit.loose,
                  child: MaterialButton(
                    onPressed: onCancel,
                    color: Colors.green.shade300,
                    child: const Text(
                      'No',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text("${DateFormat('MMMM dd').format(widget.date)} Workouts"),
          centerTitle: true,
        ),
        body: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: value.getWorkoutsForDay(widget.date).length,
          itemBuilder: (context, index) => SlidingTile(
            text: value.getWorkoutsForDay(widget.date)[index].name,
            onForwardPress: () =>
              goToWorkoutPage(value.getWorkoutList()[index].name),
            onSettingsPress: () =>
              onSettingsPress(value.getWorkoutList()[index].name),
            onDeletePress: () =>
              onDeletePress(value.getWorkoutList()[index].name),
            imageLocation: dumbellImg,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => addWorkoutToDay(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}