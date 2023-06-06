import 'package:flutter/material.dart';

class WorkoutsPageContent extends StatefulWidget {
  const WorkoutsPageContent({Key? key}) : super(key: key);

  @override
  WorkoutsPageState get createState => WorkoutsPageState();
}

class WorkoutsPageState extends State<WorkoutsPageContent> {
  String? chosenWorkout;
  List<String> workouts = <String>['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButton<String>(
          hint: const Text("Select Items: "),
          value: chosenWorkout,
          onChanged: (String? newValue) {
            setState(() {
              chosenWorkout = newValue;
            });
          },
          items: workouts.map((String workout) {
            return DropdownMenuItem<String>(
              value: workout,
              child: Text(workout),
            );
          }).toList(),
        ),
      ),
    );
  }
}
