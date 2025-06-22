import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/popups/duration_picker_modal.dart';
import 'package:workout_app/components/popups/weight_picker_modal.dart';
import 'package:workout_app/components/popups/exercise_selection_modal.dart';
import 'package:workout_app/components/text_divider.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/utils/themes.dart';

enum WorkoutType { exercises, timed }

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

  // Workout type selection
  WorkoutType _selectedType = WorkoutType.exercises;

  // Exercises workout fields
  List<Exercise> _selectedExercises = [];

  // Timed workout fields
  int _duration = 300; // Default 5 minutes in seconds
  double _weight = 0; // Default weight

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.workout?.name ?? '');
    _descriptionController = TextEditingController(
      text: widget.workout?.description ?? '',
    );

    // Initialize based on existing workout type
    if (widget.workout != null) {
      if (widget.workout is ExercisesWorkout) {
        _selectedType = WorkoutType.exercises;
        _selectedExercises = (widget.workout as ExercisesWorkout).exercises;
      } else if (widget.workout is TimedWorkout) {
        _selectedType = WorkoutType.timed;
        final timedWorkout = widget.workout as TimedWorkout;
        _duration = timedWorkout.duration;
        _weight = timedWorkout.weight ?? 0;
      }
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

  String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Future<void> _showDurationPicker() async {
    await showDialog(
      context: context,
      builder:
          (context) => DurationPickerModal(
            initialDurationInSeconds: _duration,
            title: 'Set Duration',
            onDurationChanged: (newDuration) {
              setState(() {
                _duration = newDuration;
              });
            },
          ),
    );
  }

  Future<void> _showWeightPicker() async {
    await showDialog(
      context: context,
      builder:
          (context) => WeightPickerModal(
            initialWeight: _weight,
            title: 'Set Weight',
            unit: 'lbs',
            minWeight: 0,
            maxWeight: 100,
            divisions: 100,
            onWeightChanged: (newWeight) {
              setState(() {
                _weight = newWeight;
              });
            },
          ),
    );
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
      builder:
          (context) => ExerciseSelectionModal(
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
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Workout'),
            content: Text(
              'Are you sure you want to delete "${widget.workout?.name}"?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop('DELETE');
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }

  Widget _buildExercisesWorkoutSection(ThemeProvider themeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Add New Exercise Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
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
              color: themeProvider.getButtonBackground().withAlpha(
                (0.3 * 255).toInt(),
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: themeProvider.getTextColor().withAlpha(
                  (0.2 * 255).toInt(),
                ),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.fitness_center,
                  size: 48,
                  color: themeProvider.getTextColor().withAlpha(
                    (0.5 * 255).toInt(),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'No exercises selected',
                  style: TextStyle(
                    fontSize: 16,
                    color: themeProvider.getTextColor().withAlpha(
                      (0.7 * 255).toInt(),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add exercises to create a complete workout',
                  style: TextStyle(
                    fontSize: 14,
                    color: themeProvider.getTextColor().withAlpha(
                      (0.5 * 255).toInt(),
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTimedWorkoutSection(ThemeProvider themeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Duration Picker
        Card(
          color: themeProvider.getButtonBackground(),
          child: ListTile(
            leading: Icon(Icons.timer, color: themeProvider.primaryColor),
            title: Text(
              'Duration',
              style: TextStyle(
                color: themeProvider.getTextColor(),
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              _formatDuration(_duration),
              style: TextStyle(
                color: themeProvider.getTextColor().withAlpha(
                  (0.7 * 255).toInt(),
                ),
                fontSize: 16,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: themeProvider.getTextColor(),
            ),
            onTap: _showDurationPicker,
          ),
        ),
        const SizedBox(height: 16),

        // Weight Picker
        Card(
          color: themeProvider.getButtonBackground(),
          child: ListTile(
            leading: Icon(
              Icons.fitness_center,
              color: themeProvider.primaryColor,
            ),
            title: Text(
              'Weight',
              style: TextStyle(
                color: themeProvider.getTextColor(),
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              _weight > 0 ? '${_weight.toStringAsFixed(1)} lbs' : 'No weight',
              style: TextStyle(
                color: themeProvider.getTextColor().withAlpha(
                  (0.7 * 255).toInt(),
                ),
                fontSize: 16,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: themeProvider.getTextColor(),
            ),
            onTap: _showWeightPicker,
          ),
        ),
      ],
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
                        labelStyle: TextStyle(
                          color: themeProvider.getTextColor(),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: themeProvider.getTextColor().withAlpha(
                              (0.3 * 255).toInt(),
                            ),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: themeProvider.primaryColor,
                          ),
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
                        labelStyle: TextStyle(
                          color: themeProvider.getTextColor(),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: themeProvider.getTextColor().withAlpha(
                              (0.3 * 255).toInt(),
                            ),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: themeProvider.primaryColor,
                          ),
                        ),
                      ),
                      maxLines: 3,
                    ),
                    TextDivider(text: 'Workout Type', icon: Icons.timer),

                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedType = WorkoutType.exercises;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    _selectedType == WorkoutType.exercises
                                        ? themeProvider.primaryColor.withAlpha(
                                          (0.2 * 255).toInt(),
                                        )
                                        : themeProvider.getButtonBackground(),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                      _selectedType == WorkoutType.exercises
                                          ? themeProvider.primaryColor
                                          : themeProvider
                                              .getTextColor()
                                              .withAlpha((0.3 * 255).toInt()),
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.fitness_center,
                                    color:
                                        _selectedType == WorkoutType.exercises
                                            ? themeProvider.primaryColor
                                            : themeProvider.getTextColor(),
                                    size: 32,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Exercises',
                                    style: TextStyle(
                                      color:
                                          _selectedType == WorkoutType.exercises
                                              ? themeProvider.primaryColor
                                              : themeProvider.getTextColor(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedType = WorkoutType.timed;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    _selectedType == WorkoutType.timed
                                        ? themeProvider.primaryColor.withAlpha(
                                          (0.2 * 255).toInt(),
                                        )
                                        : themeProvider.getButtonBackground(),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                      _selectedType == WorkoutType.timed
                                          ? themeProvider.primaryColor
                                          : themeProvider
                                              .getTextColor()
                                              .withAlpha((0.3 * 255).toInt()),
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.timer,
                                    color:
                                        _selectedType == WorkoutType.timed
                                            ? themeProvider.primaryColor
                                            : themeProvider.getTextColor(),
                                    size: 32,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Timed',
                                    style: TextStyle(
                                      color:
                                          _selectedType == WorkoutType.timed
                                              ? themeProvider.primaryColor
                                              : themeProvider.getTextColor(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Workout-specific content
                    if (_selectedType == WorkoutType.exercises)
                      _buildExercisesWorkoutSection(themeProvider)
                    else
                      _buildTimedWorkoutSection(themeProvider),

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
                  color: themeProvider.getTextColor().withAlpha(
                    (0.1 * 255).toInt(),
                  ),
                ),
              ),
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Workout workout;

                      if (_selectedType == WorkoutType.exercises) {
                        workout = ExercisesWorkout(
                          id:
                              widget.workout?.id ??
                              DateTime.now().millisecondsSinceEpoch,
                          name: _nameController.text,
                          description:
                              _descriptionController.text.isEmpty
                                  ? null
                                  : _descriptionController.text,
                          exercises: _selectedExercises,
                        );
                      } else {
                        workout = TimedWorkout(
                          id:
                              widget.workout?.id ??
                              DateTime.now().millisecondsSinceEpoch,
                          name: _nameController.text,
                          description:
                              _descriptionController.text.isEmpty
                                  ? null
                                  : _descriptionController.text,
                          duration: _duration,
                          weight: _weight > 0 ? _weight : null,
                        );
                      }

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
