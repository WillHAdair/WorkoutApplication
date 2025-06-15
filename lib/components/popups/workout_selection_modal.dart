import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/models/workout.dart';
import 'package:workout_app/utils/themes.dart';

class WorkoutSelectionModal extends StatefulWidget {
  final List<Workout> availableWorkouts;
  final List<Workout> selectedWorkouts;

  const WorkoutSelectionModal({
    super.key,
    required this.availableWorkouts,
    required this.selectedWorkouts,
  });

  @override
  State<WorkoutSelectionModal> createState() => _WorkoutSelectionModalState();
}

class _WorkoutSelectionModalState extends State<WorkoutSelectionModal> {
  late List<Workout> _selectedWorkouts;
  late List<Workout> _filteredWorkouts;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedWorkouts = List.from(widget.selectedWorkouts);
    _filteredWorkouts = List.from(widget.availableWorkouts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterWorkouts(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredWorkouts = List.from(widget.availableWorkouts);
      } else {
        _filteredWorkouts = widget.availableWorkouts.where((workout) {
          final name = workout.name.toLowerCase();
          final description = workout.description?.toLowerCase() ?? '';
          final searchLower = query.toLowerCase();
          
          return name.contains(searchLower) ||
                 description.contains(searchLower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

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
                  'Select Workouts',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.getTextColor(),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Search bar
                TextField(
                  controller: _searchController,
                  style: TextStyle(color: themeProvider.getTextColor()),
                  decoration: InputDecoration(
                    hintText: 'Search workouts...',
                    hintStyle: TextStyle(
                      color: themeProvider.getTextColor().withOpacity(0.5),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: themeProvider.getTextColor().withOpacity(0.7),
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: themeProvider.getTextColor().withOpacity(0.7),
                            ),
                            onPressed: () {
                              _searchController.clear();
                              _filterWorkouts('');
                            },
                          )
                        : null,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: themeProvider.getTextColor().withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeProvider.primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: _filterWorkouts,
                ),
                const SizedBox(height: 20),
                
                // Selected count info
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: themeProvider.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: themeProvider.primaryColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${_selectedWorkouts.length} selected',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: themeProvider.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                
                // Workout list
                SizedBox(
                  height: 350,
                  width: double.maxFinite,
                  child: _filteredWorkouts.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _searchQuery.isNotEmpty ? Icons.search_off : Icons.fitness_center,
                                size: 48,
                                color: themeProvider.getTextColor().withOpacity(0.3),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _searchQuery.isNotEmpty 
                                    ? 'No workouts found for "$_searchQuery"'
                                    : 'No workouts available',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: themeProvider.getTextColor().withOpacity(0.6),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (_searchQuery.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                TextButton(
                                  onPressed: () {
                                    _searchController.clear();
                                    _filterWorkouts('');
                                  },
                                  child: Text(
                                    'Clear search',
                                    style: TextStyle(
                                      color: themeProvider.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: _filteredWorkouts.length,
                          itemBuilder: (context, index) {
                            final workout = _filteredWorkouts[index];
                            final isSelected = _selectedWorkouts.any((w) => w.id == workout.id);
                            
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: isSelected 
                                    ? themeProvider.primaryColor.withOpacity(0.1)
                                    : themeProvider.getButtonBackground(),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected 
                                      ? themeProvider.primaryColor
                                      : themeProvider.getTextColor().withOpacity(0.2),
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: CheckboxListTile(
                                title: Text(
                                  workout.name,
                                  style: TextStyle(
                                    color: themeProvider.getTextColor(),
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (workout.description != null)
                                      Text(
                                        workout.description!,
                                        style: TextStyle(
                                          color: themeProvider.getTextColor().withOpacity(0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                    Text(
                                      '${workout.exercises.length} exercise${workout.exercises.length == 1 ? '' : 's'}',
                                      style: TextStyle(
                                        color: themeProvider.getTextColor().withOpacity(0.5),
                                        fontSize: 11,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                                value: isSelected,
                                activeColor: themeProvider.primaryColor,
                                checkColor: Colors.white,
                                controlAffinity: ListTileControlAffinity.trailing,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      if (!_selectedWorkouts.any((w) => w.id == workout.id)) {
                                        _selectedWorkouts.add(workout);
                                      }
                                    } else {
                                      _selectedWorkouts.removeWhere((w) => w.id == workout.id);
                                    }
                                  });
                                },
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 20),
                
                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          color: themeProvider.getTextColor(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(_selectedWorkouts);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeProvider.primaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Select (${_selectedWorkouts.length})',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Close button
          Positioned(
            right: 10,
            top: 10,
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
