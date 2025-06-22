import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/models/exercise.dart';
import 'package:workout_app/utils/themes.dart';

class ExerciseSelectionModal extends StatefulWidget {
  final List<Exercise> availableExercises;
  final List<Exercise> selectedExercises;

  const ExerciseSelectionModal({
    super.key,
    required this.availableExercises,
    required this.selectedExercises,
  });

  @override
  State<ExerciseSelectionModal> createState() => _ExerciseSelectionModalState();
}

class _ExerciseSelectionModalState extends State<ExerciseSelectionModal> {
  late List<Exercise> _selectedExercises;
  late List<Exercise> _filteredExercises;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedExercises = List.from(widget.selectedExercises);
    _filteredExercises = List.from(widget.availableExercises);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterExercises(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredExercises = List.from(widget.availableExercises);
      } else {
        _filteredExercises = widget.availableExercises.where((exercise) {
          final name = exercise.name.toLowerCase();
          final description = exercise.description?.toLowerCase() ?? '';
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
                  'Select Exercises',
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
                    hintText: 'Search exercises...',
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
                              _filterExercises('');
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
                  onChanged: _filterExercises,
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
                        '${_selectedExercises.length} selected',
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
                  // Exercise list
                SizedBox(
                  height: 350,
                  width: double.maxFinite,
                  child: _filteredExercises.isEmpty
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
                                    ? 'No exercises found for "$_searchQuery"'
                                    : 'No exercises available',
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
                                    _filterExercises('');
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
                          itemCount: _filteredExercises.length,
                          itemBuilder: (context, index) {
                            final exercise = _filteredExercises[index];
                            final isSelected = _selectedExercises.any((e) => e.id == exercise.id);
                            
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
                                  exercise.name,
                                  style: TextStyle(
                                    color: themeProvider.getTextColor(),
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                  ),
                                ),
                                value: isSelected,
                                activeColor: themeProvider.primaryColor,
                                checkColor: Colors.white,
                                controlAffinity: ListTileControlAffinity.trailing,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      if (!_selectedExercises.any((e) => e.id == exercise.id)) {
                                        _selectedExercises.add(exercise);
                                      }
                                    } else {
                                      _selectedExercises.removeWhere((e) => e.id == exercise.id);
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
                        Navigator.of(context).pop(_selectedExercises);
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
                        'Select (${_selectedExercises.length})',
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
