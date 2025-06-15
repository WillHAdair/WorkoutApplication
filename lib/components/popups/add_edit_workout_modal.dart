import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/utils/themes.dart';

class AddEditWorkoutModal extends StatefulWidget {
  final Workout? workout;
  final List<Exercise> availableExercises;

  const AddEditWorkoutModal({
    super.key,
    this.workout,
    this.availableExercises = const [],
  });

  @override
  State<AddEditWorkoutModal> createState() => _AddEditWorkoutModalState();
}

class _AddEditWorkoutModalState extends State<AddEditWorkoutModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  List<Exercise> _selectedExercises = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.workout?.name ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.workout?.description ?? '',
    );
    if (widget.workout != null) {
      _selectedExercises = List.from(widget.workout!.exercises);
    }
    _loadMockExercises();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  void _loadMockExercises() {
    // Note: Mock exercises are handled via the _availableExercises getter
    // This method is kept for future use when loading real exercise data
  }

  List<Exercise> get _availableExercises {
    if (widget.availableExercises.isNotEmpty) {
      return widget.availableExercises;
    }
    
    // Return mock exercises if none provided
    return [
      ContinualExercise(
        id: 101,
        name: 'Push-ups',
        description: 'Classic bodyweight chest exercise',
        exerciseType: ExerciseType.sets,
        time: 0,
      ),
      ContinualExercise(
        id: 102,
        name: 'Squats',
        description: 'Lower body strength exercise',
        exerciseType: ExerciseType.sets,
        time: 0,
      ),
      ContinualExercise(
        id: 103,
        name: 'Plank',
        description: 'Core strengthening exercise',
        exerciseType: ExerciseType.continual,
        time: 60,
      ),
      ContinualExercise(
        id: 104,
        name: 'Jumping Jacks',
        description: 'Cardio warm-up exercise',
        exerciseType: ExerciseType.continual,
        time: 30,
      ),
      ContinualExercise(
        id: 105,
        name: 'Burpees',
        description: 'Full body conditioning exercise',
        exerciseType: ExerciseType.sets,
        time: 0,
      ),
    ];
  }

  Future<void> _showExerciseSelectionModal() async {
    if (_availableExercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No exercises available. Create exercises first.'),
        ),
      );
      return;
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Exercises'),
        content: StatefulBuilder(
          builder: (context, setDialogState) {
            return SizedBox(
              width: double.maxFinite,
              height: 400,
              child: ListView.builder(
                itemCount: _availableExercises.length,
                itemBuilder: (context, index) {
                  final exercise = _availableExercises[index];
                  final isSelected = _selectedExercises.any((e) => e.id == exercise.id);
                  
                  return CheckboxListTile(
                    title: Text(exercise.name),
                    subtitle: exercise.description != null 
                        ? Text(exercise.description!) 
                        : Text('Type: ${exercise.exerciseType.name}'),
                    value: isSelected,
                    onChanged: (value) {
                      setDialogState(() {
                        if (value == true) {
                          if (!_selectedExercises.any((e) => e.id == exercise.id)) {
                            _selectedExercises.add(exercise);
                          }
                        } else {
                          _selectedExercises.removeWhere((e) => e.id == exercise.id);
                        }
                      });
                    },
                  );
                },
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
    
    // Refresh the UI after the dialog closes
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isEditing = widget.workout != null;

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
                  isEditing ? 'Edit Workout' : 'Add Workout',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.getTextColor(),
                  ),
                ),
                const SizedBox(height: 20),
                
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Workout Name
                      TextFormField(
                        controller: _nameController,
                        style: TextStyle(color: themeProvider.getTextColor()),
                        decoration: InputDecoration(
                          labelText: 'Workout Name *',
                          labelStyle: TextStyle(color: themeProvider.getTextColor()),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: themeProvider.getTextColor().withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: themeProvider.primaryColor),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a workout name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      
                      // Description
                      TextFormField(
                        controller: _descriptionController,
                        style: TextStyle(color: themeProvider.getTextColor()),
                        decoration: InputDecoration(
                          labelText: 'Description (optional)',
                          labelStyle: TextStyle(color: themeProvider.getTextColor()),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: themeProvider.getTextColor().withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: themeProvider.primaryColor),
                          ),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),
                      
                      // Exercises Section
                      Text(
                        'Exercises',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.getTextColor(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Add New Exercise Button (placeholder)
                      OutlinedButton.icon(
                        onPressed: () {
                          // TODO: Add functionality later
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Add new exercise functionality coming soon!'),
                            ),
                          );
                        },
                        icon: Icon(Icons.add, color: themeProvider.primaryColor),
                        label: Text(
                          'Create New Exercise',
                          style: TextStyle(color: themeProvider.primaryColor),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: themeProvider.primaryColor),
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Select from Existing Exercises
                      OutlinedButton.icon(
                        onPressed: _showExerciseSelectionModal,
                        icon: Icon(Icons.fitness_center, color: themeProvider.primaryColor),
                        label: Text(
                          'Select from Existing Exercises',
                          style: TextStyle(color: themeProvider.primaryColor),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: themeProvider.primaryColor),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Selected Exercises List
                      if (_selectedExercises.isNotEmpty) ...[
                        Text(
                          'Selected Exercises:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: themeProvider.getTextColor(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: themeProvider.getTextColor().withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListView.builder(
                            itemCount: _selectedExercises.length,
                            itemBuilder: (context, index) {
                              final exercise = _selectedExercises[index];
                              return ListTile(
                                dense: true,
                                title: Text(
                                  exercise.name,
                                  style: TextStyle(color: themeProvider.getTextColor()),
                                ),
                                subtitle: Text(
                                  exercise.description ?? 'Type: ${exercise.exerciseType.name}',
                                  style: TextStyle(
                                    color: themeProvider.getTextColor().withOpacity(0.7),
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: themeProvider.rejectColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _selectedExercises.removeAt(index);
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                
                // Action Buttons
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                      if (isEditing) const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final workout = Workout(
                              id: widget.workout?.id ?? DateTime.now().millisecondsSinceEpoch,
                              name: _nameController.text,
                              description: _descriptionController.text.isEmpty 
                                  ? null 
                                  : _descriptionController.text,
                              exercises: _selectedExercises,
                            );
                            Navigator.of(context).pop(workout);
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
                  ),
                ),
              ],
            ),
          ),
          // Close button (always visible, just cancels)
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
