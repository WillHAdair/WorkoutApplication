import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/models/schedule_day.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/utils/themes.dart';

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
  List<Workout> _selectedWorkouts = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.scheduleDay?.name ?? '',
    );
    if (widget.scheduleDay != null) {
      _selectedWorkouts = List.from(widget.scheduleDay!.workouts);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _showWorkoutDropdown() {
    if (widget.availableWorkouts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No workouts available. Create workouts first.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Workouts'),
        content: StatefulBuilder(
          builder: (context, setDialogState) {
            return SizedBox(
              width: double.maxFinite,
              height: 300,
              child: ListView.builder(
                itemCount: widget.availableWorkouts.length,
                itemBuilder: (context, index) {
                  final workout = widget.availableWorkouts[index];
                  final isSelected = _selectedWorkouts.any((w) => w.id == workout.id);
                  
                  return CheckboxListTile(
                    title: Text(workout.name),
                    subtitle: workout.description != null 
                        ? Text(workout.description!) 
                        : null,
                    value: isSelected,
                    onChanged: (value) {
                      setDialogState(() {
                        if (value == true) {
                          if (!_selectedWorkouts.any((w) => w.id == workout.id)) {
                            _selectedWorkouts.add(workout);
                          }
                        } else {
                          _selectedWorkouts.removeWhere((w) => w.id == workout.id);
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
            onPressed: () {
              setState(() {}); // Refresh main dialog
              Navigator.of(context).pop();
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isEditing = widget.scheduleDay != null;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: themeProvider.getPopupBackgroundColor(),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isEditing ? 'Edit Schedule Day' : 'Add Schedule Day',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeProvider.getTextColor(),
              ),
            ),
            const SizedBox(height: 24),
            
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Day Name
                  TextFormField(
                    controller: _nameController,
                    style: TextStyle(color: themeProvider.getTextColor()),
                    decoration: InputDecoration(
                      labelText: 'Day Name *',
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
                        return 'Please enter a day name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  
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
                  
                  // Add New Workout Button (placeholder)
                  OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Add functionality later
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Add new workout functionality coming soon!'),
                        ),
                      );
                    },
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
                    onPressed: _showWorkoutDropdown,
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
                      'Selected Workouts:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: themeProvider.getTextColor(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: themeProvider.getTextColor().withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView.builder(
                        itemCount: _selectedWorkouts.length,
                        itemBuilder: (context, index) {
                          final workout = _selectedWorkouts[index];
                          return ListTile(
                            dense: true,
                            title: Text(
                              workout.name,
                              style: TextStyle(color: themeProvider.getTextColor()),
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
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: themeProvider.getTextColor()),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final scheduleDay = ScheduleDay(
                        id: widget.scheduleDay?.id ?? DateTime.now().millisecondsSinceEpoch,
                        name: _nameController.text,
                        workouts: _selectedWorkouts,
                      );
                      Navigator.of(context).pop(scheduleDay);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeProvider.primaryColor,
                  ),
                  child: Text(
                    isEditing ? 'Update' : 'Add',                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],            ),
          ],
        ),
        ),
        // Delete button positioned in top right corner (only show when editing)
        if (isEditing)
          Positioned(
            right: 10,
            top: 10,
            child: GestureDetector(
              onTap: () {
                // Return a special value to indicate deletion
                Navigator.of(context).pop('DELETE');
              },
              child: Icon(
                Icons.delete,
                size: 24,
                color: themeProvider.rejectColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
