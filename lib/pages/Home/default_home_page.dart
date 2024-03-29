import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/basic_widgets/custom_textfield.dart';
import 'package:workout_app/components/basic_widgets/text_divider.dart';
import 'package:workout_app/components/popups/list_popup.dart';
import 'package:workout_app/components/tiles/custom_tile.dart';
import 'package:workout_app/components/heat_map.dart';
import 'package:workout_app/components/popups/customizable_dialog.dart';
import 'package:workout_app/components/tiles/sliding_tile.dart';
import 'package:workout_app/data/theme_provider.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/pages/Workouts/workout_page.dart';
import 'package:workout_app/pages/Workouts/workouts_page.dart';

class DefaultHomePage extends StatefulWidget {
  final void Function(bool) onWorkoutStatusChange;

  const DefaultHomePage({Key? key, required this.onWorkoutStatusChange})
      : super(key: key);

  @override
  DefaultHomePageState createState() => DefaultHomePageState();
}

class DefaultHomePageState extends State<DefaultHomePage> {
  final workoutNameController = TextEditingController();

  void createNewWorkout() {
    showDialog(
        context: context,
        builder: (context) {
          return CustomizableDialog(customTextFields: [
            CustomTextField(
              controller: workoutNameController,
              name: "Workout Name",
              prefixIcon: Icons.text_fields_outlined,
              inputType: TextInputType.name,
            )
          ], onSave: save, onCancel: cancel);
        });
  }

  void goToWorkoutPage(String workoutName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WorkoutPage(
                  workoutName: workoutName,
                )));
  }

  void goToWorkoutsPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const WorkoutsPage()));
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
    Provider.of<WorkoutData>(context, listen: false)
        .changeWorkoutName(oldWorkoutName, newWorkoutName);
    Navigator.pop(context);
    clear();
  }

  void onSettingsPress(String workoutName) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomizableDialog(customTextFields: [
          CustomTextField(
            controller: workoutNameController,
            name: "New Name",
            prefixIcon: Icons.settings,
            inputType: TextInputType.text,
          )
        ], onSave: () => edit(workoutName), onCancel: cancel);
      },
    );
  }

  void startWorkout(Workout workout) {
    Navigator.pop(context);
    Provider.of<WorkoutData>(context, listen: false).startWorkout(workout);
    widget.onWorkoutStatusChange(true);
  }

  void chooseWorkout() {
    showDialog(
        context: context,
        builder: (context) {
          return ListPopup(
            onChange: (workout) => startWorkout(workout),
            onCancel: cancel,
            workouts: Provider.of<WorkoutData>(context).getFilledWorkouts(),
            errorMessage: 'No populated workouts',
            preferred: Provider.of<WorkoutData>(context).getTodaysWorkout(),
            heading: const <String, IconData>{
              'Today\'s Workout': Icons.today,
              'Other workouts': Icons.checklist
            },
          );
        });
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
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            CustomHeatMap(
                datasets: value.heatMapDataSet,
                startDate: value.getStartDate()),
            value.getTodaysWorkout() != null
                ? Column(
                    children: [
                      const TextDivider(
                          text: 'Today\'s workout', icon: Icons.today),
                      SlidingTile(
                        text: value.getTodaysWorkout()!.name,
                        onForwardPress: () =>
                            goToWorkoutPage(value.getTodaysWorkout()!.name),
                        onSettingsPress: () =>
                            onSettingsPress(value.getTodaysWorkout()!.name),
                        onDeletePress: () =>
                            onDeletePress(value.getTodaysWorkout()!.name),
                        imageLocation: dumbellImg,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            const TextDivider(text: 'Other workouts', icon: Icons.checklist),
            CustomTile(
              text: 'View/AddWorkouts',
              onForwardPress: () => goToWorkoutsPage(),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(22),
          child: TextButton(
            onPressed: chooseWorkout,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(16),
              backgroundColor: Provider.of<ThemeProvider>(context).acceptColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.start,
                  color: Colors.white,
                ),
                Text(
                  'Start Workout',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
