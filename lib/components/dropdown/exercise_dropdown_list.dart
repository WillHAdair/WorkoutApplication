import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/models/workout_set.dart';

import '../../data/theme_provider.dart';

// ignore: must_be_immutable
class ExerciseDropdownList extends StatefulWidget {
  final String title;
  final List<WorkoutSet> sets;
  bool isCompleted;
  VoidCallback? onSettingsPress;
  VoidCallback? onDeletePress;
  VoidCallback? onChanged;

  ExerciseDropdownList({
    Key? key,
    required this.title,
    required this.sets,
    required this.isCompleted,
    this.onChanged,
    this.onSettingsPress,
    this.onDeletePress,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ExerciseDropdownListState createState() => _ExerciseDropdownListState();
}

class _ExerciseDropdownListState extends State<ExerciseDropdownList> {
  bool isDropdownOpen = false;
  @override
  Widget build(BuildContext context) {
    Color tileColor = Provider.of<ThemeProvider>(context).getTileColor();
    Color chipColor = Provider.of<ThemeProvider>(context).getChipcolor();
    if (widget.isCompleted) {
      tileColor = Provider.of<ThemeProvider>(context).tileCompleted;
      chipColor = Provider.of<ThemeProvider>(context).chipCompleted;
    }
    Container contents = Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          ListTile(
            leading: widget.onChanged != null
                ? Checkbox(
                    value: widget.isCompleted,
                    onChanged: (value) {
                      widget.onChanged!();
                      setState(() {
                        widget.isCompleted = value!;
                      });
                    },
                  )
                : const SizedBox.shrink(),
            title: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                isDropdownOpen
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_right,
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
              children: widget.sets
                  .map((workoutSet) => Container(
                      decoration: BoxDecoration(
                        color: workoutSet.isCompleted
                            ? Provider.of<ThemeProvider>(context).tileCompleted
                            : tileColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading:
                            Text("${widget.sets.indexOf(workoutSet) + 1})"),
                        title: Row(
                          children: [
                            Chip(
                              label: Text("${workoutSet.reps} Reps"),
                              backgroundColor: workoutSet.isCompleted
                                  ? Provider.of<ThemeProvider>(context)
                                      .chipCompleted
                                  : chipColor,
                            ),
                            const SizedBox(width: 10),
                            Chip(
                              label: Text("${workoutSet.weight} lb"),
                              backgroundColor: workoutSet.isCompleted
                                  ? Provider.of<ThemeProvider>(context)
                                      .chipCompleted
                                  : chipColor,
                            ),
                          ],
                        ),
                        trailing: widget.onChanged != null
                            ? Checkbox(
                                value: widget.isCompleted
                                    ? true
                                    : workoutSet.isCompleted,
                                onChanged: (value) => {
                                  setState(
                                    () {
                                      workoutSet.isCompleted = value!;
                                    },
                                  )
                                },
                              )
                            : const SizedBox.shrink(),
                      )))
                  .toList(),
            ),
        ],
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          widget.onSettingsPress != null && widget.onDeletePress != null
              ? Slidable(
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => widget.onSettingsPress!(),
                        backgroundColor:
                            Provider.of<ThemeProvider>(context).settingsTile,
                        icon: Icons.settings,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      SlidableAction(
                        onPressed: (context) => widget.onDeletePress!(),
                        backgroundColor:
                            Provider.of<ThemeProvider>(context).deleteTile,
                        icon: Icons.delete,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ],
                  ),
                  child: contents,
                )
              : contents,
        ],
      ),
    );
  }
}
