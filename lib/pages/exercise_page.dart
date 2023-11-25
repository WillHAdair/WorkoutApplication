import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/basic_widgets/custom_textfield.dart';
import 'package:workout_app/components/popups/customizable_dialog.dart';
import 'package:workout_app/components/tiles/text_tile.dart';
import 'package:workout_app/data/theme_provider.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/workout.dart';

// ignore: must_be_immutable
class ExercisePage extends StatefulWidget {
  final Workout workout;
  final Exercise exercise;
  const ExercisePage({Key? key, required this.workout, required this.exercise})
      : super(key: key);
  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  int editIndex = 0;
  final nameController = TextEditingController();
  final weightController = TextEditingController();
  final repsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.exercise.name;
  }

  void save() {
    Provider.of<WorkoutData>(context, listen: false)
        .addSet(widget.exercise, weightController.text, repsController.text);
    repsController.clear();
    weightController.clear();
    cancel();
  }

  void cancel() {
    Navigator.pop(context);
  }

  void createSet() {
    showDialog(
        context: context,
        builder: (context) {
          return CustomizableDialog(customTextFields: [
            CustomTextField(
              controller: repsController,
              name: "Reps",
              prefixIcon: Icons.add_task,
              inputType: TextInputType.number,
            ),
            CustomTextField(
              controller: weightController,
              name: "Weight",
              prefixIcon: Icons.scale,
              inputType: TextInputType.number,
            ),
          ], onSave: save, onCancel: cancel);
        });
  }

  void editSet(int index) {
    repsController.text = Provider.of<WorkoutData>(context, listen: false)
        .getRelevantSet(widget.exercise, index)
        .reps;
    weightController.text = Provider.of<WorkoutData>(context, listen: false)
        .getRelevantSet(widget.exercise, index)
        .weight;
    setState(() {
      editIndex = index;
    });
    showDialog(
        context: context,
        builder: (context) {
          return CustomizableDialog(customTextFields: [
            CustomTextField(
              controller: repsController,
              name: "Reps",
              prefixIcon: Icons.add_task,
              inputType: TextInputType.number,
            ),
            CustomTextField(
              controller: weightController,
              name: "Weight",
              prefixIcon: Icons.scale,
              inputType: TextInputType.number,
            ),
          ], onSave: edit, onCancel: cancel);
        });
  }

  void deleteSet(int index) {
    setState(() {
      editIndex = index;
    });
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
                    onPressed: () => delete(),
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
                    onPressed: () => Navigator.pop(context),
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

  void delete() {
    Provider.of<WorkoutData>(context, listen: false)
        .deleteSet(widget.exercise, editIndex);
    cancel();
  }

  void edit() {
    Provider.of<WorkoutData>(context, listen: false).editSet(
        widget.exercise, editIndex, weightController.text, repsController.text);
    weightController.clear();
    repsController.clear();
    cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(widget.exercise.name),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => createSet(),
          backgroundColor: Provider.of<ThemeProvider>(context).acceptColor,
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.edit_calendar,
                    color: Provider.of<ThemeProvider>(context).secondaryColor,
                  ),
                  const SizedBox(width: 10),
                  const Text('Exercise Values',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                ],
              ),
              Row(
                children: [
                  const Text('Exercise name: '),
                  const SizedBox(width: 5),
                  Expanded(
                    child: CustomTextField(
                      controller: nameController,
                      name: 'Exercise',
                      prefixIcon: Icons.person,
                      inputType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    color: Provider.of<ThemeProvider>(context).secondaryColor,
                  ),
                  const SizedBox(width: 10),
                  const Text('Exercise Sets',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getSetNumber(widget.workout, widget.exercise),
                itemBuilder: (context, index) => TextTile(
                  onClick: () => {},
                  contents: Row(
                    children: [
                      Text("Set ${index + 1}"),
                      const SizedBox(width: 10),
                      Chip(
                        label: Text("${widget.exercise.sets[index].reps} Reps"),
                        backgroundColor:
                            Provider.of<ThemeProvider>(context).getChipcolor(),
                      ),
                      const SizedBox(width: 10),
                      Chip(
                        label:
                            Text("${widget.exercise.sets[index].weight} Lbs"),
                        backgroundColor:
                            Provider.of<ThemeProvider>(context).getChipcolor(),
                      )
                    ],
                  ),
                  isSlideable: true,
                  onSettingsPress: () => editSet(index),
                  onDeletePress: () => deleteSet(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
