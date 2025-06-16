import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/popups/add_edit_schedule_day_modal.dart';
import 'package:workout_app/components/text_divider.dart';
import 'package:workout_app/models/schedule_day.dart';
import 'package:workout_app/models/workout_schedule.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/utils/themes.dart';

class AddEditSchedulePage extends StatefulWidget {
  final WorkoutSchedule? schedule;

  const AddEditSchedulePage({super.key, this.schedule});

  @override
  State<AddEditSchedulePage> createState() => _AddEditSchedulePageState();
}

class _AddEditSchedulePageState extends State<AddEditSchedulePage> {
  final _formKey = GlobalKey<FormState>();
  late WorkoutSchedule _schedule;
  DateTime? _endDate;
  List<Workout> _availableWorkouts = [];

  @override
  void initState() {
    super.initState();
    _loadMockWorkouts();    if (widget.schedule != null) {
      _schedule = widget.schedule!;
      _endDate = widget.schedule!.endDate;
    } else {
      _schedule = WorkoutSchedule(
        id: -1,
        name: '',
        startDate: DateTime.now(),
        endDate: null,
        isActive: true,
        days: [],
      );
      _endDate = null;
    }
  }

  void _loadMockWorkouts() {
    // Mock data for testing
    _availableWorkouts = [
      Workout(id: 1, name: 'Bench Press', exercises: []),
      Workout(id: 2, name: 'Incline Dumbbell Press', exercises: []),
      Workout(id: 3, name: 'Deadlift', exercises: []),
      Workout(id: 4, name: 'Squats', exercises: []),
      Workout(id: 5, name: 'Pull-ups', exercises: []),
      Workout(id: 6, name: 'Barbell Rows', exercises: []),
    ];
  }

  Future<void> _showAddEditScheduleDayModal({
    ScheduleDay? scheduleDay,
    int? index,
  }) async {
    final result = await showDialog<dynamic>(
      context: context,
      builder:
          (context) => AddEditScheduleDayModal(
            scheduleDay: scheduleDay,
            availableWorkouts: _availableWorkouts,
          ),
    );

    if (result != null) {
      setState(() {
        if (result == 'DELETE' && index != null) {
          // Delete existing day
          _schedule.days.removeAt(index);
          _schedule = _schedule.copyWith(days: List.from(_schedule.days));
        } else if (result is ScheduleDay) {
          if (index != null) {
            // Editing existing day
            _schedule.days[index] = result;
          } else {
            // Adding new day
            _schedule = _schedule.copyWith(days: [..._schedule.days, result]);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.schedule != null;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.getBackgroundColor(),
      appBar: AppBar(
        title: Text(
          isEditing ? 'E D I T   S C H E D U L E' : 'A D D   S C H E D U L E',
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
                    TextDivider(text: 'Schedule Name', icon: Icons.badge),
                    // Schedule Name (required)
                    TextFormField(
                      initialValue: _schedule.name,
                      style: TextStyle(color: themeProvider.getTextColor()),
                      decoration: InputDecoration(
                        labelText: 'Schedule Name *',
                        labelStyle: TextStyle(
                          color: themeProvider.getTextColor(),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: themeProvider.getTextColor().withOpacity(
                              0.3,
                            ),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: themeProvider.primaryColor,
                          ),
                        ),
                      ),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Enter a name'
                                  : null,
                      onSaved:
                          (value) =>
                              _schedule = _schedule.copyWith(name: value ?? ''),
                      onChanged:
                          (value) =>
                              _schedule = _schedule.copyWith(name: value),
                    ),
                    const SizedBox(height: 24), // Schedule Dates
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextDivider(
                          text: 'Schedule Dates',
                          icon: Icons.date_range,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              'Start Date *: ',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: themeProvider.getTextColor(),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _schedule.startDate.toLocal().toString().split(
                                  ' ',
                                )[0],
                                style: TextStyle(
                                  color: themeProvider.getTextColor(),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.calendar_today,
                                color: themeProvider.primaryColor,
                              ),
                              onPressed: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: _schedule.startDate,
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null) {
                                  setState(() {
                                    _schedule = _schedule.copyWith(
                                      startDate: picked,
                                    );
                                    // If end date is before start date, clear end date
                                    if (_endDate != null &&
                                        _endDate!.isBefore(picked)) {
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
                            Text(
                              'End Date: ',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: themeProvider.getTextColor(),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _endDate == null
                                    ? 'None'
                                    : _endDate!.toLocal().toString().split(
                                      ' ',
                                    )[0],
                                style: TextStyle(
                                  color: themeProvider.getTextColor(),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.calendar_today,
                                color: themeProvider.primaryColor,
                              ),
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
                                icon: Icon(
                                  Icons.clear,
                                  color: themeProvider.getTextColor(),
                                ),
                                tooltip: 'Clear End Date',
                                onPressed: () {
                                  setState(() {
                                    _endDate = null;
                                  });
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24), // Workout Schedule
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextDivider(
                          text: 'Schedule Days',
                          icon: Icons.schedule,
                        ),
                        // Days of week header (dynamic, rolling from start date)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(7, (i) {
                            // 1 = Monday, 7 = Sunday in Dart's DateTime
                            const weekDays = [
                              'M',
                              'T',
                              'W',
                              'T',
                              'F',
                              'S',
                              'S',
                            ];
                            int startWeekday =
                                _schedule
                                    .startDate
                                    .weekday; // 1 (Mon) - 7 (Sun)
                            // Adjust to 0-based index for our weekDays array
                            int idx = (startWeekday - 1 + i) % 7;
                            return Expanded(
                              child: Center(
                                child: Text(
                                  weekDays[idx],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: themeProvider.getTextColor(),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 8), // Schedule days grid
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
                                      final day = days[idx];
                                      return Expanded(
                                        child: GestureDetector(
                                          onTap:
                                              () =>
                                                  _showAddEditScheduleDayModal(
                                                    scheduleDay: day,
                                                    index: idx,
                                                  ),
                                          child: Container(
                                            margin: const EdgeInsets.all(2),
                                            height:
                                                60, // Fixed height for consistency
                                            decoration: BoxDecoration(
                                              color:
                                                  themeProvider
                                                      .getButtonBackground(),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: Border.all(
                                                color: themeProvider
                                                    .primaryColor
                                                    .withOpacity(0.3),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  day.workouts.isEmpty
                                                      ? Icons
                                                          .hotel // Rest day
                                                      : Icons
                                                          .fitness_center, // Workout day
                                                  size: 20,
                                                  color:
                                                      themeProvider
                                                          .primaryColor,
                                                ),
                                                const SizedBox(height: 4),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 2,
                                                      ),
                                                  child: Text(
                                                    day.name,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color:
                                                          themeProvider
                                                              .getTextColor(),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
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
                        const SizedBox(height: 16),
                        // Add day buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton.icon(
                              icon: Icon(
                                Icons.add,
                                color: themeProvider.primaryColor,
                              ),
                              label: Text(
                                'Add Day',
                                style: TextStyle(
                                  color: themeProvider.primaryColor,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: themeProvider.primaryColor,
                                ),
                              ),
                              onPressed: () => _showAddEditScheduleDayModal(),
                            ),
                            OutlinedButton.icon(
                              icon: Icon(
                                Icons.hotel,
                                color: themeProvider.primaryColor,
                              ),
                              label: Text(
                                'Rest Day',
                                style: TextStyle(
                                  color: themeProvider.primaryColor,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: themeProvider.primaryColor,
                                ),
                              ),
                              onPressed: () {
                                final restDay = ScheduleDay(
                                  id: DateTime.now().millisecondsSinceEpoch,
                                  name: 'Rest Day',
                                  workouts: [],
                                );
                                setState(() {
                                  _schedule = _schedule.copyWith(
                                    days: [..._schedule.days, restDay],
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
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
                      _formKey.currentState!.save();
                      Navigator.of(
                        context,
                      ).pop(_schedule.copyWith(endDate: _endDate));
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
                    isEditing ? 'Update Schedule' : 'Save Schedule',
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
