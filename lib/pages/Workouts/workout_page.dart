import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/basic_widgets/custom_textfield.dart';
import 'package:workout_app/components/dropdown/exercise_dropdown_list.dart';
import 'package:workout_app/components/popups/customizable_dialog.dart';
import 'package:workout_app/pages/exercise_page.dart';
import 'package:workout_app/data/theme_provider.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/workout.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;

  const WorkoutPage({super.key, required this.workoutName});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  void onCheckBoxChanged(String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkOffExercise(widget.workoutName, exerciseName);
  }

  final exerciseNameController = TextEditingController();
  final exerciseWeightController = TextEditingController();
  final exerciseSetsController = TextEditingController();
  final exerciseRepsController = TextEditingController();

  void save() {
    Provider.of<WorkoutData>(context, listen: false).addExercise(
        widget.workoutName, exerciseNameController.text, [], false);

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
  }

  void clear() {
    exerciseNameController.clear();
    exerciseWeightController.clear();
    exerciseSetsController.clear();
    exerciseRepsController.clear();
  }

  void moveToExercisePage(bool createNew, {String name = ''}) {
    String exerciseName = name;
    if (createNew) {
      Provider.of<WorkoutData>(context, listen: false).addExercise(
          widget.workoutName, exerciseNameController.text, [], false);
      Navigator.pop(context);
      exerciseName = exerciseNameController.text;
    }
    Workout workout = Provider.of<WorkoutData>(context, listen: false)
        .getRelevantWorkout(widget.workoutName)!;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ExercisePage(
                  workout: workout,
                  exercise: Provider.of<WorkoutData>(context, listen: false)
                      .getRelevantExercise(workout, exerciseName),
                )));
  }

  void createNewExercise() {
    clear();
    showDialog(
        context: context,
        builder: (context) {
          return CustomizableDialog(customTextFields: [
            CustomTextField(
                controller: exerciseNameController,
                name: "Exercise Name",
                prefixIcon: Icons.fitness_center,
                inputType: TextInputType.text)
          ], onSave: () => moveToExercisePage(true), onCancel: cancel);
        });
  }

  void edit(String exerciseName) {
    Workout relevantWorkout = Provider.of<WorkoutData>(context, listen: false)
        .getRelevantWorkout(widget.workoutName)!;
    Exercise relevantExercise = Provider.of<WorkoutData>(context, listen: false)
        .getRelevantExercise(relevantWorkout, exerciseName);
    Provider.of<WorkoutData>(context, listen: false).editExerciseName(
        relevantWorkout, relevantExercise, exerciseNameController.text);

    Navigator.pop(context);
  }

  void editExercise(String exerciseName) {
    exerciseNameController.text = exerciseName;
    showDialog(
        context: context,
        builder: (context) {
          return CustomizableDialog(
              customTextFields: [
                CustomTextField(
                    controller: exerciseNameController,
                    name: "Exercise Name",
                    prefixIcon: Icons.fitness_center,
                    inputType: TextInputType.text)
              ],
              onSave: () {
                edit(exerciseName);
                moveToExercisePage(false, name: exerciseNameController.text);
              },
              onCancel: cancel);
        });
  }

  void delete(String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .deleteExercise(widget.workoutName, exerciseName);

    Navigator.pop(context);
  }

  void deleteExercise(String exerciseName) {
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
                    onPressed: () => delete(exerciseName),
                    color: Provider.of<ThemeProvider>(context).rejectColor,
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
                    onPressed: cancel,
                    color: Provider.of<ThemeProvider>(context).acceptColor,
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
          title: Text(widget.workoutName),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => createNewExercise(),
          backgroundColor: Provider.of<ThemeProvider>(context).acceptColor,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
          itemBuilder: (context, index) => ExerciseDropdownList(
            title: value
                .getRelevantWorkout(widget.workoutName)!
                .exercises[index]
                .name,
            sets: value
                .getRelevantWorkout(widget.workoutName)!
                .exercises[index]
                .sets,
            isCompleted: false,
            onSettingsPress: () => editExercise(value
                .getRelevantWorkout(widget.workoutName)!
                .exercises[index]
                .name),
            onDeletePress: () => deleteExercise(value
                .getRelevantWorkout(widget.workoutName)!
                .exercises[index]
                .name),
          ),
        ),
      ),
    );
  }
}
