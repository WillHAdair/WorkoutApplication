import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/custom_textfield.dart';
import 'package:workout_app/components/workout_tile.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/pages/workout_page.dart';
import 'package:workout_app/pages/workouts_page.dart';

import '../components/heat_map.dart';
import '../components/customizable_dialog.dart';
import '../data/settings_data.dart';
import '../data/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<WorkoutData>(context, listen: false).initializeWorkoutList();
    final settingsData = Provider.of<SettingsData>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    settingsData.initializeSettingsList();
    bool darkMode = settingsData.getRelevantSetting("IsDarkMode").value as bool;
    bool notificationsOn =
        settingsData.getRelevantSetting("Notifications").value as bool;
    bool trendTracking =
        settingsData.getRelevantSetting("ProgressTracking").value as bool;

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      themeProvider.toggleTheme(darkMode);
    });
  }

  final workoutNameController = TextEditingController();

  void createNewWorkout() {
    showDialog(
        context: context,
        builder: (context) {
          return CustomizableDialog(customTextFields: [
            CustomTextField(
                controller: workoutNameController,
                hintText: "Workout Name",
                obscureText: false)
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
      context,
      MaterialPageRoute(
        builder: (context) => const WorkoutsPage()));
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
              hintText: "New Name",
              obscureText: false)
        ], onSave: () => edit(workoutName), onCancel: cancel);
      },
    );
  }

  void startWorkout(String workoutName) {

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
      builder: (context, value, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text('Workout Tracker'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            CustomHeatMap(
                datasets: value.heatMapDataSet,
                startDate: value.getStartDate()),
            const SizedBox(height: 10),
            const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Icon(
                    Icons.today,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10),
                  Text('Today\'s workout',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
                ],
              ),
            WorkoutTile(
              workoutName: value.getWorkoutList()[0].name,
              onForwardPress: () =>
                goToWorkoutPage(value.getWorkoutList()[0].name),
              onSettingsPress: () =>
                onSettingsPress(value.getWorkoutList()[0].name),
              onDeletePress: () =>
                onDeletePress(value.getWorkoutList()[0].name),
              ),
            const SizedBox(height: 10),
            const Row(
              children: [
                SizedBox(width: 10),
                Icon(
                  Icons.checklist,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text('Other workouts',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: 
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: const Text(
                    "View/Add Workouts",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () => goToWorkoutsPage(),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding:const EdgeInsets.all(22),
              child: TextButton(
              onPressed: () => startWorkout(value.getWorkoutList()[0].name),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16), 
                backgroundColor: Colors.green,
                foregroundColor: Colors.green[200], 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  ),
                ),
              child: const Text(
                'Start Workout',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ), 
            ), 
          ],
        ),
      ),
    );
  }
}
