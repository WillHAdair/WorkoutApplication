import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/models/schedule_day.dart';
import 'package:workout_app/models/user_profile.dart';
import 'package:workout_app/models/workout_schedule.dart';
import 'package:workout_app/utils/themes.dart';

class WorkoutScheduleDialog extends StatefulWidget {
  final WorkoutSchedule? schedule;

  const WorkoutScheduleDialog({super.key, this.schedule});

  @override
  State<WorkoutScheduleDialog> createState() => _WorkoutScheduleDialogState();
}

class _WorkoutScheduleDialogState extends State<WorkoutScheduleDialog> {
  final _formKey = GlobalKey<FormState>();
  late WorkoutSchedule _schedule;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    if (widget.schedule != null) {
      _schedule = widget.schedule!;
      _endDate = widget.schedule!.endDate;
    } else {
      _schedule = WorkoutSchedule(
        id: -1,
        name: '',
        startDate: DateTime.now(),
        endDate: null,
        isActive: true,
        userProfile: UserProfile(
          id: 1,
          height: 70,
          weight: 195,
          lastUpdated: DateTime.now(),
        ),
        days: [],
      );
      _endDate = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.schedule != null;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      isEditing
                          ? 'Edit Workout Schedule'
                          : 'Add Workout Schedule',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Schedule Name (required)
                    TextFormField(
                      initialValue: _schedule.name,
                      decoration: const InputDecoration(
                        labelText: 'Schedule Name *',
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter a name' : null,
                      onSaved: (value) =>
                          _schedule = _schedule.copyWith(name: value ?? ''),
                      onChanged: (value) =>
                          _schedule = _schedule.copyWith(name: value),
                    ),
                    const SizedBox(height: 16),
                    // Start Date (required)
                    Row(
                      children: [
                        const Text(
                          'Start Date *: ',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Expanded(
                          child: Text(
                            _schedule.startDate.toLocal().toString().split(' ')[0],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: _schedule.startDate,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setState(() {
                                _schedule = _schedule.copyWith(startDate: picked);
                                // If end date is before start date, clear end date
                                if (_endDate != null && _endDate!.isBefore(picked)) {
                                  _endDate = null;
                                }
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // End Date (optional)
                    Row(
                      children: [
                        const Text(
                          'End Date: ',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Expanded(
                          child: Text(
                            _endDate == null
                                ? 'None'
                                : _endDate!.toLocal().toString().split(' ')[0],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: _endDate ?? _schedule.startDate,
                              firstDate: _schedule.startDate,
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setState(() {
                                _endDate = picked;
                              });
                            }
                          },
                        ),
                        if (_endDate != null)
                          IconButton(
                            icon: const Icon(Icons.clear),
                            tooltip: 'Clear End Date',
                            onPressed: () {
                              setState(() {
                                _endDate = null;
                              });
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // --- Workout Days Calendar ---
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Days of week header (dynamic, rolling from start date)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(7, (i) {
                            // 1 = Monday, 7 = Sunday in Dart's DateTime
                            const weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                            int startWeekday = _schedule.startDate.weekday; // 1 (Mon) - 7 (Sun)
                            // Adjust to 0-based index for our weekDays array
                            int idx = (startWeekday - 1 + i) % 7;
                            return Expanded(
                              child: Center(
                                child: Text(
                                  weekDays[idx],
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 8),
                        // Schedule days grid
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final days = _schedule.days;
                            final rows = (days.length / 7).ceil();
                            return Column(
                              children: List.generate(rows, (row) {
                                return Row(
                                  children: List.generate(7, (col) {
                                    final idx = row * 7 + col;
                                    if (idx < days.length) {
                                      return Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.all(2),
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(color: Colors.grey.shade400),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.fitness_center, // or any icon you want
                                                size: 20,
                                                color: Colors.grey[800],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      // Empty cell
                                      return const Expanded(child: SizedBox());
                                    }
                                  }),
                                );
                              }),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        // Add day and rest day buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton.icon(
                              icon: const Icon(Icons.add),
                              label: const Text('Add Day'),
                              onPressed: () {
                                setState(() {
                                  _schedule = _schedule.copyWith(
                                    days: [
                                      ..._schedule.days,
                                      ScheduleDay(
                                        id: DateTime.now().millisecondsSinceEpoch,
                                        name: 'Day ${_schedule.days.length + 1}',
                                        workouts: [],
                                      ),
                                    ],
                                  );
                                });
                              },
                            ),
                            const SizedBox(width: 12),
                            OutlinedButton.icon(
                              icon: const Icon(Icons.hotel), // hotel = bed/rest
                              label: const Text('Rest Day'),
                              onPressed: () {
                                setState(() {
                                  _schedule = _schedule.copyWith(
                                    days: [
                                      ..._schedule.days,
                                      // For now, same as add day (customize as needed)
                                      ScheduleDay(
                                        id: DateTime.now().millisecondsSinceEpoch,
                                        name: 'Day ${_schedule.days.length + 1}',
                                        workouts: [],
                                      ),
                                    ],
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Navigator.of(context).pop(
                              _schedule.copyWith(endDate: _endDate),
                            );
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
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Cancel (X) button in the top right
          Positioned(
            right: 8,
            top: 8,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
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
