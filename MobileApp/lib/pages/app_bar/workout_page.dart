import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/cards/workout_card.dart';
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
          ContinualExercise(id: 1, name: 'Bench Press', description: 'Chest exercise', time: 0),
          ContinualExercise(id: 2, name: 'Shoulder Press', description: 'Shoulder exercise', time: 0),
        ],
      ),
      ExercisesWorkout(
        id: 2,
        name: 'Pull Day',
        description: 'Back and biceps workout',
        exercises: [
          ContinualExercise(id: 3, name: 'Pull-ups', description: 'Back exercise', time: 0),
          ContinualExercise(id: 4, name: 'Barbell Rows', description: 'Back exercise', time: 0),
        ],
      ),
      TimedWorkout(
        id: 3,
        name: 'HIIT Cardio',
        description: 'High-intensity interval training',
        duration: 1800, // 30 minutes
        weight: null,
      ),
      TimedWorkout(
        id: 4,
        name: 'Weighted Run',
        description: 'Running with weighted vest',
        duration: 2400, // 40 minutes
        weight: 20.0, // 20 lbs
      ),
      ExercisesWorkout(
        id: 5,
        name: 'Leg Day',
        description: 'Lower body strength training',
        exercises: [
          ContinualExercise(id: 5, name: 'Squats', description: 'Leg exercise', time: 0),
          ContinualExercise(id: 6, name: 'Deadlifts', description: 'Full body exercise', time: 0),
        ],
      ),
      TimedWorkout(
        id: 6,
        name: 'Light Jog',
        description: 'Easy pace recovery run',
        duration: 1200, // 20 minutes
        weight: null,
      ),
    ];
  }

  Future<void> _addWorkout() async {
    final result = await Navigator.of(context).push<dynamic>(
      MaterialPageRoute(
        builder: (context) => AddEditWorkoutPage(
          availableExercises: _getAvailableExercises(), // Add this
        ),
      ),
    );
    if (result != null && result is Workout) {
      setState(() {
        _workouts.add(result);
        _workouts.sort((a, b) => a.id.compareTo(b.id));
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Added workout "${result.name}"')),
        );
      }
    }
  }

  Future<void> _editWorkout(Workout workout) async {
    final result = await Navigator.of(context).push<dynamic>(
      MaterialPageRoute(
        builder: (context) => AddEditWorkoutPage(
          workout: workout,
          availableExercises: _getAvailableExercises(), // Add this
        ),
      ),
    );
    if (result != null) {
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
            SnackBar(content: Text('Updated workout "${result.name}"')),
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

  // Add this helper method to provide available exercises
  List<Exercise> _getAvailableExercises() {
    // Extract all unique exercises from existing workouts
    final Set<Exercise> exercises = {};
    for (final workout in _workouts) {
      if (workout is ExercisesWorkout) {
        exercises.addAll(workout.exercises);
      }
    }
    
    // Add some default exercises if none exist
    if (exercises.isEmpty) {
      exercises.addAll([
        ContinualExercise(id: 101, name: 'Push-ups', description: 'Bodyweight chest exercise', time: 0),
        ContinualExercise(id: 102, name: 'Squats', description: 'Lower body exercise', time: 0),
        ContinualExercise(id: 103, name: 'Plank', description: 'Core exercise', time: 60),
        ContinualExercise(id: 104, name: 'Jumping Jacks', description: 'Cardio exercise', time: 30),
        ContinualExercise(id: 105, name: 'Burpees', description: 'Full body exercise', time: 0),
      ]);
    }
    
    return exercises.toList();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.getBackgroundColor(),
      body:
          _workouts.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.fitness_center,
                      size: 64,
                      color: themeProvider.getTextColor().withAlpha(
                        (0.5 * 255).toInt(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No workouts yet',
                      style: TextStyle(
                        fontSize: 18,
                        color: themeProvider.getTextColor().withAlpha(
                          (0.7 * 255).toInt(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add your first workout to get started!',
                      style: TextStyle(
                        fontSize: 14,
                        color: themeProvider.getTextColor().withAlpha(
                          (0.5 * 255).toInt(),
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : Builder(
                builder: (context) {
                  // Calculate bottom padding based on FAB size and safe area
                  final bottomPadding = MediaQuery.of(context).padding.bottom + 80.0;
                  return ListView.builder(
                    padding: EdgeInsets.fromLTRB(6.0, 0, 6.0, bottomPadding),
                    itemCount: _workouts.length,
                    itemBuilder: (context, index) {
                      final workout = _workouts[index];
                      return WorkoutCard(
                        workout: workout,
                        onEditPress: () => _editWorkout(workout),
                        onDeletePress: () => _deleteWorkout(workout),
                      );
                    },
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
