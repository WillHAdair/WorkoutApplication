import 'package:flutter/material.dart';
import 'workouts_content.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: IndexedStack(
        children: [
          WorkoutsPageContent(),
        ],
      )
    );
  }
}
