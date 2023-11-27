import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/theme_provider.dart';
import '../../models/exercise.dart';

// ignore: must_be_immutable
class WorkoutDropdownList extends StatefulWidget {
  final String title;
  final List<Exercise> exercises;
  bool isSelected;
  final void Function(bool?)? onChanged;

  WorkoutDropdownList({
    Key? key, 
    required this.title, 
    required this.exercises, 
    required this.isSelected,
    required this.onChanged,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WorkoutDropdownListState createState() => _WorkoutDropdownListState();
}

class _WorkoutDropdownListState extends State<WorkoutDropdownList> {
  bool isDropdownOpen = false;
  @override
  Widget build(BuildContext context) { 
    Color tileColor = Provider.of<ThemeProvider>(context).getTileColor();
    Color chipColor = Provider.of<ThemeProvider>(context).getChipcolor();
    if (widget.isSelected) {
      tileColor = Provider.of<ThemeProvider>(context).tileCompleted;
      chipColor = Provider.of<ThemeProvider>(context).chipCompleted;
    }
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            ListTile(
              leading: Checkbox(
                value: widget.isSelected,
                onChanged: (value) => {
                  setState(() {
                    widget.isSelected = value!;
                  }),
                  widget.onChanged!.call(value),
                },
              ),
              title: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  isDropdownOpen ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                ),
                onPressed: () {
                  setState(() {
                    isDropdownOpen = !isDropdownOpen;
                  });
                },
              ),
            ),
            if (isDropdownOpen)
              Column(
                children: widget.exercises
                    .map((exercise) => Container(
                      decoration: BoxDecoration(
                        color: exercise.isCompleted ? Provider.of<ThemeProvider>(context).tileCompleted : tileColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                          leading: Text("${widget.exercises.indexOf(exercise) + 1})"),
                          title: Row(
                            children: [
                              Chip(
                                label: Text(exercise.name),
                                backgroundColor: exercise.isCompleted ? 
                                Provider.of<ThemeProvider>(context).chipCompleted : chipColor,
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        )
                      )
                    )
                .toList(),
              ),
          ],
        ),
      ),
    );
  }
}