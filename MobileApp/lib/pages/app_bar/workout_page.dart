import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/workout_card.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/pages/add_edit_workout_page.dart';
import 'package:workout_app/utils/themes.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  List<Workout> _workouts = [];

  @override
  void initState() {
    super.initState();
    _loadMockWorkouts();
  }

  void _loadMockWorkouts() {
    // Mock data for testing - replace with actual data loading later
    _workouts = [
      ExercisesWorkout(
        id: 1,
        name: 'Push Day',
        description: 'Chest, shoulders, and triceps workout',
        exercises: [
          ContinualExercise(
            id: 1,
            name: 'Bench Press',
            time: 0,
          ),
          ContinualExercise(
            id: 2,
            name: 'Shoulder Press',
            time: 0,
          ),
        ],
      ),
      ExercisesWorkout(
        id: 2,
        name: 'Pull Day',
        description: 'Back and biceps workout',
        exercises: [
          ContinualExercise(
            id: 3,
            name: 'Pull-ups',
            time: 0,
          ),
          ContinualExercise(
            id: 4,
            name: 'Barbell Rows',
            time: 0,
          ),
        ],
      ),
      ExercisesWorkout(
        id: 3,
        name: 'Leg Day',
        description: 'Lower body strength training',
        exercises: [
          ContinualExercise(
            id: 5,
            name: 'Squats',
            time: 0,
          ),
          ContinualExercise(
            id: 6,
            name: 'Deadlifts',
            time: 0,
          ),
        ],
      ),
      ExercisesWorkout(
        id: 4,
        name: 'Cardio',
        description: 'Cardiovascular endurance training',
        exercises: [
          ContinualExercise(
            id: 7,
            name: 'Running',
            time: 30,
          ),
          ContinualExercise(
            id: 8,
            name: 'Cycling',
            time: 45,
          ),
        ],
      ),
    ];
  }  Future<void> _addWorkout() async {
    final result = await Navigator.of(context).push<dynamic>(
      MaterialPageRoute(
        builder: (context) => const AddEditWorkoutPage(),
      ),
    );if (result != null && result is Workout) {
      setState(() {
        _workouts.add(result);
        _workouts.sort((a, b) => a.id.compareTo(b.id));
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added workout "${result.name}"'),
          ),
        );
      }
    }
  }  Future<void> _editWorkout(Workout workout) async {
    final result = await Navigator.of(context).push<dynamic>(
      MaterialPageRoute(
        builder: (context) => AddEditWorkoutPage(workout: workout),
      ),
    );if (result != null) {
      setState(() {
        if (result == 'DELETE') {
          // Delete the workout
          _workouts.removeWhere((w) => w.id == workout.id);
        } else if (result is Workout) {
          // Update the workout
          final index = _workouts.indexWhere((w) => w.id == workout.id);
          if (index != -1) {
            _workouts[index] = result;
          }
        }
      });
      
      if (mounted) {
        if (result == 'DELETE') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Deleted workout "${workout.name}"'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  setState(() {
                    _workouts.add(workout);
                    _workouts.sort((a, b) => a.id.compareTo(b.id));
                  });
                },
              ),
            ),
          );
        } else if (result is Workout) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Updated workout "${result.name}"'),
            ),
          );
        }
      }
    }
  }

  void _deleteWorkout(Workout workout) {
    setState(() {
      _workouts.removeWhere((w) => w.id == workout.id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted workout "${workout.name}"'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _workouts.add(workout);
              _workouts.sort((a, b) => a.id.compareTo(b.id));
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);    return Scaffold(
      backgroundColor: themeProvider.getBackgroundColor(),
      body: _workouts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fitness_center,
                    size: 64,
                    color: themeProvider.getTextColor().withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No workouts yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: themeProvider.getTextColor().withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add your first workout to get started!',
                    style: TextStyle(
                      fontSize: 14,
                      color: themeProvider.getTextColor().withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              itemCount: _workouts.length,
              itemBuilder: (context, index) {
                final workout = _workouts[index];
                return WorkoutCard(
                  workout: workout,
                  onEditPress: () => _editWorkout(workout),
                  onDeletePress: () => _deleteWorkout(workout),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWorkout,
        backgroundColor: themeProvider.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
