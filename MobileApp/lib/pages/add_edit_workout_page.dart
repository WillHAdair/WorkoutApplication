import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/popups/exercise_selection_modal.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/utils/themes.dart';

class AddEditWorkoutPage extends StatefulWidget {
  final Workout? workout;
  final List<Exercise> availableExercises;

  const AddEditWorkoutPage({
    super.key,
    this.workout,
    this.availableExercises = const [],
  });

  @override
  State<AddEditWorkoutPage> createState() => _AddEditWorkoutPageState();
}

class _AddEditWorkoutPageState extends State<AddEditWorkoutPage> {
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
    if (widget.workout != null && widget.workout is ExercisesWorkout) {
      _selectedExercises = (widget.workout as ExercisesWorkout).exercises;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
        time: 0,
      ),
      ContinualExercise(
        id: 102,
        name: 'Squats',
        description: 'Lower body strength exercise',
        time: 0,
      ),
      ContinualExercise(
        id: 103,
        name: 'Plank',
        description: 'Core strengthening exercise',
        time: 60,
      ),
      ContinualExercise(
        id: 104,
        name: 'Jumping Jacks',
        description: 'Cardio warm-up exercise',
        time: 30,
      ),
      ContinualExercise(
        id: 105,
        name: 'Burpees',
        description: 'Full body conditioning exercise',
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

    final result = await showDialog<List<Exercise>>(
      context: context,
      builder: (context) => ExerciseSelectionModal(
        availableExercises: _availableExercises,
        selectedExercises: _selectedExercises,
      ),
    );
    
    if (result != null) {
      setState(() {
        _selectedExercises = result;
      });
    }
  }

  void _deleteWorkout() {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Workout'),
        content: Text('Are you sure you want to delete "${widget.workout?.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop('DELETE'); // Return DELETE to parent
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isEditing = widget.workout != null;

    return Scaffold(
      backgroundColor: themeProvider.getBackgroundColor(),
      appBar: AppBar(
        title: Text(
          isEditing ? 'E D I T   W O R K O U T' : 'A D D   W O R K O U T',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: themeProvider.getTextColor(),
          ),
        ),
        backgroundColor: themeProvider.getHeaderBackgroundColor(),
        iconTheme: IconThemeData(color: themeProvider.getTextColor()),
        elevation: 2,
        centerTitle: true,
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteWorkout,
              tooltip: 'Delete Workout',
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
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
                    const SizedBox(height: 24),
                    
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
                      maxLines: 3,
                    ),
                    const SizedBox(height: 32),
                    
                    // Exercises Section
                    Text(
                      'Exercises',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.getTextColor(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Add New Exercise Button (placeholder)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
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
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Select from Existing Exercises
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _showExerciseSelectionModal,
                        icon: Icon(Icons.fitness_center, color: themeProvider.primaryColor),
                        label: Text(
                          'Select from Existing Exercises',
                          style: TextStyle(color: themeProvider.primaryColor),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: themeProvider.primaryColor),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Selected Exercises List
                    if (_selectedExercises.isNotEmpty) ...[
                      Text(
                        'Selected Exercises (${_selectedExercises.length})',
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
                        itemCount: _selectedExercises.length,
                        itemBuilder: (context, index) {
                          final exercise = _selectedExercises[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            color: themeProvider.getButtonBackground(),
                            child: ListTile(
                              title: Text(
                                exercise.name,
                                style: TextStyle(
                                  color: themeProvider.getTextColor(),
                                  fontWeight: FontWeight.w500,
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
                            ),
                          );
                        },
                      ),
                    ] else ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: themeProvider.getButtonBackground().withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: themeProvider.getTextColor().withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.fitness_center,
                              size: 48,
                              color: themeProvider.getTextColor().withOpacity(0.5),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No exercises selected',
                              style: TextStyle(
                                fontSize: 16,
                                color: themeProvider.getTextColor().withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Add exercises to create a complete workout',
                              style: TextStyle(
                                fontSize: 14,
                                color: themeProvider.getTextColor().withOpacity(0.5),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 100), // Space for bottom button
                  ],
                ),
              ),
            ),
          ),
          // Fixed bottom save button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: themeProvider.getBackgroundColor(),
              border: Border(
                top: BorderSide(
                  color: themeProvider.getTextColor().withOpacity(0.1),
                ),
              ),
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final workout = ExercisesWorkout(
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
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    isEditing ? 'Update Workout' : 'Save Workout',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
