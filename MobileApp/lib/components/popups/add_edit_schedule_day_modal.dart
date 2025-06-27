import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/schedule_day.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/utils/themes.dart';
import 'package:workout_app/components/popups/workout_selection_modal.dart';
import 'package:workout_app/pages/add_edit_workout_page.dart';

class AddEditScheduleDayModal extends StatefulWidget {
  final ScheduleDay? scheduleDay;
  final List<Workout> availableWorkouts;

  const AddEditScheduleDayModal({
    super.key,
    this.scheduleDay,
    this.availableWorkouts = const [],
  });

  @override
  State<AddEditScheduleDayModal> createState() => _AddEditScheduleDayModalState();
}

class _AddEditScheduleDayModalState extends State<AddEditScheduleDayModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _calorieGoalController;
  List<Workout> _selectedWorkouts = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.scheduleDay?.name ?? '',
    );
    _calorieGoalController = TextEditingController(
      text: widget.scheduleDay?.calorieGoal?.toString() ?? '',
    );
    if (widget.scheduleDay != null) {
      _selectedWorkouts = List.from(widget.scheduleDay!.workouts);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _calorieGoalController.dispose();
    super.dispose();
  }  Future<void> _showWorkoutSelectionModal() async {
    if (widget.availableWorkouts.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No workouts available. Create workouts first.'),
          ),
        );
      }
      return;
    }

    final result = await showDialog<List<Workout>>(
      context: context,
      builder: (context) => WorkoutSelectionModal(
        availableWorkouts: widget.availableWorkouts,
        selectedWorkouts: _selectedWorkouts,
      ),
    );
    
    if (result != null && mounted) {
      setState(() {
        _selectedWorkouts = result;
      });
    }
  }

  Future<void> _addNewWorkout() async {
    final result = await Navigator.of(context).push<Workout>(
      MaterialPageRoute(
        builder: (context) => AddEditWorkoutPage(
          availableExercises: _getAvailableExercises(),
        ),
      ),
    );
    
    if (result != null && mounted) {
      setState(() {
        // Add the new workout to selected workouts
        _selectedWorkouts.add(result);
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added workout "${result.name}"')),
      );
    }
  }

  List<Exercise> _getAvailableExercises() {
    final Set<Exercise> exercises = {};
    for (final workout in widget.availableWorkouts) {
      if (workout is ExercisesWorkout) {
        exercises.addAll(workout.exercises);
      }
    }
    
    if (exercises.isEmpty) {
      return [
        ContinualExercise(id: 101, name: 'Push-ups', description: 'Bodyweight chest exercise', time: 0),
        ContinualExercise(id: 102, name: 'Squats', description: 'Lower body exercise', time: 0),
        ContinualExercise(id: 103, name: 'Plank', description: 'Core exercise', time: 60),
      ];
    }
    
    return exercises.toList();
  }

  String _getWorkoutTypeDescription(Workout workout) {
    if (workout is ExercisesWorkout) {
      final exerciseCount = workout.exercises.length;
      return '$exerciseCount exercise${exerciseCount == 1 ? '' : 's'}';
    } else if (workout is TimedWorkout) {
      final minutes = workout.duration ~/ 60;
      final seconds = workout.duration % 60;
      final durationText = '${minutes}:${seconds.toString().padLeft(2, '0')}';
      String description = 'Timed workout ($durationText)';
      if (workout.weight != null && workout.weight! > 0) {
        description += ' • ${workout.weight!.toStringAsFixed(1)} lbs';
      }
      return description;
    }
    return 'Unknown workout type';
  }

  ImageIcons _getWorkoutIcon(Workout workout) {
    if (workout is ExercisesWorkout) {
      return ImageIcons.dumbell;
    } else if (workout is TimedWorkout) {
      final timedWorkout = workout;
      if (timedWorkout.weight != null && timedWorkout.weight! > 0) {
        return ImageIcons.dumbell;
      } else {
        return ImageIcons.timed;
      }
    }
    return ImageIcons.dumbell;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isEditing = widget.scheduleDay != null;

    return Dialog(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: themeProvider.getPopupBackgroundColor(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEditing ? 'Edit Schedule Day' : 'Add Schedule Day',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.getTextColor(),
                  ),                ),
                const SizedBox(height: 20),
                
                Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [                  // Day Name
                  TextFormField(
                    controller: _nameController,
                    style: TextStyle(color: themeProvider.getTextColor()),
                    decoration: InputDecoration(
                      labelText: 'Day Name *',
                      labelStyle: TextStyle(color: themeProvider.getTextColor()),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: themeProvider.getTextColor().withAlpha((0.3 * 2.55).toInt()),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themeProvider.primaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a day name';
                      }
                      return null;                    },
                  ),
                  const SizedBox(height: 20),
                  
                  // Calorie Goal
                  TextFormField(
                    controller: _calorieGoalController,
                    style: TextStyle(color: themeProvider.getTextColor()),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Calorie Goal (optional)',
                      hintText: 'Leave empty to use maintenance calories',
                      labelStyle: TextStyle(color: themeProvider.getTextColor()),
                      hintStyle: TextStyle(
                        color: themeProvider.getTextColor().withAlpha((0.5 * 2.55).toInt()),
                        fontSize: 12,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: themeProvider.getTextColor().withAlpha((0.3 * 2.55).toInt()),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: themeProvider.primaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        final calories = double.tryParse(value);
                        if (calories == null || calories <= 0) {
                          return 'Please enter a valid calorie amount';
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  
                  // Workouts Section
                  Text(
                    'Workouts',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.getTextColor(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Add New Workout Button (now functional)
                  OutlinedButton.icon(
                    onPressed: _addNewWorkout, // Updated to call the new method
                    icon: Icon(Icons.add, color: themeProvider.primaryColor),
                    label: Text(
                      'Add New Workout',
                      style: TextStyle(color: themeProvider.primaryColor),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: themeProvider.primaryColor),
                    ),
                  ),
                  const SizedBox(height: 12),
                    // Select from Existing Workouts
                  OutlinedButton.icon(
                    onPressed: _showWorkoutSelectionModal,
                    icon: Icon(Icons.fitness_center, color: themeProvider.primaryColor),
                    label: Text(
                      'Select from Existing Workouts',
                      style: TextStyle(color: themeProvider.primaryColor),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: themeProvider.primaryColor),
                    ),
                  ),
                  const SizedBox(height: 16),
                    // Selected Workouts List
                  if (_selectedWorkouts.isNotEmpty) ...[
                    Text(
                      'Selected Workouts (${_selectedWorkouts.length})',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: themeProvider.getTextColor(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _selectedWorkouts.length,
                      itemBuilder: (context, index) {
                        final workout = _selectedWorkouts[index];
                        final workoutIcon = _getWorkoutIcon(workout);
                        
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          color: themeProvider.getButtonBackground(),
                          child: ListTile(
                            leading: SizedBox(
                              height: 32.0,
                              width: 32.0,
                              child: Image.asset(
                                imageIconPaths[workoutIcon]!,
                                height: 32.0,
                                width: 32.0,
                                fit: BoxFit.contain,
                                color: themeProvider.getTextColor(),
                                colorBlendMode: BlendMode.srcIn,
                              ),
                            ),
                            title: Text(
                              workout.name,
                              style: TextStyle(
                                color: themeProvider.getTextColor(),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (workout.description != null)
                                  Text(
                                    workout.description!,
                                    style: TextStyle(
                                      color: themeProvider.getTextColor().withAlpha((0.7 * 2.55).toInt()),
                                    ),
                                  ),
                                Text(
                                  _getWorkoutTypeDescription(workout),
                                  style: TextStyle(
                                    color: themeProvider.getTextColor().withAlpha((0.5 * 2.55).toInt()),
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.remove_circle,
                                color: themeProvider.rejectColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedWorkouts.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ] else ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: themeProvider.getButtonBackground().withAlpha((0.3 * 2.55).toInt()),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: themeProvider.getTextColor().withAlpha((0.2 * 2.55).toInt()),
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.fitness_center,
                            size: 48,
                            color: themeProvider.getTextColor().withAlpha((0.5 * 2.55).toInt()),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No workouts selected',
                            style: TextStyle(
                              fontSize: 16,
                              color: themeProvider.getTextColor().withAlpha((0.7 * 2.55).toInt()),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add workouts to create a complete schedule day',
                            style: TextStyle(
                              fontSize: 14,
                              color: themeProvider.getTextColor().withAlpha((0.5 * 2.55).toInt()),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),            ),
            const SizedBox(height: 20),
            
            // Action Buttons
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,                children: [
                  if (isEditing)
                    TextButton(
                      onPressed: () {
                        // Return DELETE to indicate deletion
                        Navigator.of(context).pop('DELETE');
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        backgroundColor: themeProvider.rejectColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (isEditing) const SizedBox(width: 16),                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        double? calorieGoal;
                        if (_calorieGoalController.text.isNotEmpty) {
                          calorieGoal = double.tryParse(_calorieGoalController.text);
                        }
                        
                        final scheduleDay = ScheduleDay(
                          id: widget.scheduleDay?.id ?? DateTime.now().millisecondsSinceEpoch,
                          name: _nameController.text,
                          workouts: _selectedWorkouts,
                          calorieGoal: calorieGoal,
                        );
                        Navigator.of(context).pop(scheduleDay);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeProvider.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      isEditing ? 'Update' : 'Add',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),            ),
          ],
        ),
        ),        // Close button (always visible, just cancels)
        Positioned(
          right: 10,
          top: 10,
          child: GestureDetector(
            onTap: () {
              // Just close the modal without any action
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.close,
              size: 24,
              color: themeProvider.closeButton,
            ),
          ),
        ),
        ],
      ),
    );
  }
}
