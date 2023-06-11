import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/custom_textfield.dart';
import 'package:workout_app/components/workout_tile.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/pages/workout_page.dart';

import '../components/heat_map.dart';
import '../components/customizable_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    //TODO: Fix problem with this crashing on start
    super.initState();

    Provider.of<WorkoutData>(context, listen: false).initializeWorkoutList();
  }

  final workoutNameController = TextEditingController();

  void createNewWorkout() {
    
    showDialog(
      context: context,
      builder: (context) {
        return CustomizableDialog(
          customTextFields: [CustomTextField(
            controller: workoutNameController, 
            hintText: "Workout Name", 
            obscureText: false
            )
          ], 
          onSave: save, 
          onCancel: cancel
        );
      }
    );
  }

  void goToWorkoutPage(String workoutName) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutPage(workoutName: workoutName,)));
  }

  void save() {
    String newWorkoutName = workoutNameController.text;
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
  } 

  void clear() {
    workoutNameController.clear();
  }

  void edit(String oldWorkoutName) {
    String newWorkoutName = workoutNameController.text;
    Provider.of<WorkoutData>(context, listen: false).changeWorkoutName(oldWorkoutName, newWorkoutName);
    Navigator.pop(context);
    clear();
  }

  void onSettingsPress(String workoutName) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomizableDialog(
          customTextFields: [
            CustomTextField(
              controller: workoutNameController, 
              hintText: "New Name", 
              obscureText: false)
          ], 
          onSave: () => edit(workoutName), 
          onCancel: cancel
        );
      },
    );
  }

  void delete(String workoutName) {
    Provider.of<WorkoutData>(context, listen: false).deleteWorkout(workoutName);
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
      builder: (context, value, child) =>Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('Workout Tracker'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewWorkout,
          child: const Icon(Icons.add),
          ),
        body: ListView(
          children: [
            CustomHeatMap(datasets: value.heatMapDataSet, startDate: value.getStartDate()),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getWorkoutList().length,
              itemBuilder: (context, index) => WorkoutTile(
                workoutName: value.getWorkoutList()[index].name, 
                onForwardPress: () => goToWorkoutPage(value.getWorkoutList()[index].name),
                onSettingsPress: () => onSettingsPress(value.getWorkoutList()[index].name),
                onDeletePress: () => onDeletePress(value.getWorkoutList()[index].name),
              )
            ),
          ],
        ),
      ),
    );
  }
}


