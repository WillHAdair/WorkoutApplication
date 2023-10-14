import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/custom_textfield.dart';

import '../components/customizable_dialog.dart';
import '../components/dropdown_list.dart';
import '../data/workout_data.dart';
import '../models/exercise.dart';
import '../models/workout.dart';

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
    // TODO: make the add sets feature work
    Provider.of<WorkoutData>(context, listen: false).addExercise(
      widget.workoutName,
      exerciseNameController.text,
      [],
      false
      // exerciseWeightController.text,
      // exerciseRepsController.text,
      // exerciseSetsController.text,
    );

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

  void createNewExercise() {
    List<CustomTextField> exercises = [
      CustomTextField(
          controller: exerciseNameController,
          hintText: "Exercise name",
          obscureText: false),
      CustomTextField(
          controller: exerciseWeightController,
          hintText: "Exercise weight",
          obscureText: false),
      CustomTextField(
          controller: exerciseSetsController,
          hintText: "Exercise sets",
          obscureText: false),
      CustomTextField(
          controller: exerciseRepsController,
          hintText: "Exercise reps",
          obscureText: false),
    ];
    showDialog(
        context: context,
        builder: (context) {
          return CustomizableDialog(
              customTextFields: exercises, onSave: save, onCancel: cancel);
        });
  }

  void edit(String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false).editExercise(
      widget.workoutName,
      exerciseName,
      exerciseNameController.text,
      []
    );

    Navigator.pop(context);
    clear();
  }

  void editExercise(String exerciseName) {
    Workout relevantWorkout = Provider.of<WorkoutData>(context, listen: false)
        .getRelevantWorkout(widget.workoutName);
    Exercise relevantExercsise =
        Provider.of<WorkoutData>(context, listen: false)
            .getRelevantExercise(relevantWorkout, exerciseName);
    //Pre-set the text to the current text
    exerciseNameController.value = TextEditingValue(
      text: relevantExercsise.name,
      selection: TextSelection.fromPosition(
          TextPosition(offset: relevantExercsise.name.length)),
    );
    // exerciseWeightController.value = TextEditingValue(
    //   text: relevantExercsise.weight,
    //   selection: TextSelection.fromPosition(
    //       TextPosition(offset: relevantExercsise.weight.length)),
    // );
    // exerciseSetsController.value = TextEditingValue(
    //   text: relevantExercsise.sets,
    //   selection: TextSelection.fromPosition(
    //       TextPosition(offset: relevantExercsise.sets.length)),
    // );
    // exerciseRepsController.value = TextEditingValue(
    //   text: relevantExercsise.reps,
    //   selection: TextSelection.fromPosition(
    //       TextPosition(offset: relevantExercsise.reps.length)),
    // );

    List<CustomTextField> exercises = [
      CustomTextField(
          controller: exerciseNameController,
          hintText: "New name",
          obscureText: false),
      CustomTextField(
          controller: exerciseWeightController,
          hintText: "New weight",
          obscureText: false),
      CustomTextField(
          controller: exerciseSetsController,
          hintText: "New sets",
          obscureText: false),
      CustomTextField(
          controller: exerciseRepsController,
          hintText: "New reps",
          obscureText: false),
    ];
    showDialog(
        context: context,
        builder: (context) {
          return CustomizableDialog(
              customTextFields: exercises,
              onSave: () => edit(exerciseName),
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
                    onPressed: cancel,
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
          title: Text(widget.workoutName),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => createNewExercise(),
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
          itemBuilder: (context, index) => DropdownList(
            title:  value
              .getRelevantWorkout(widget.workoutName)
              .exercises[index]
              .name,
            sets: value
              .getRelevantWorkout(widget.workoutName)
              .exercises[index]
              .sets, 
            isCompleted: value
              .getRelevantWorkout(widget.workoutName)
              .exercises[index]
              .isCompleted, 
            onSettingsPress: () => editExercise(value
              .getRelevantWorkout(widget.workoutName)
              .exercises[index]
              .name), 
            onDeletePress: () => deleteExercise(value
              .getRelevantWorkout(widget.workoutName)
              .exercises[index]
              .name), 
            onChanged: (val) => onCheckBoxChanged(value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .name),
          ),
        ),
      ),
    );
  }
}
