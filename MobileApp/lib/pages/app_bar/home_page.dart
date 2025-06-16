import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/custom_progress_bar.dart';
import 'package:workout_app/components/fitness_heat_map.dart';
import 'package:workout_app/components/customizable_button.dart';
import 'package:workout_app/components/text_divider.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/utils/themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.getBackgroundColor(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fitness HeatMap
          const FitnessHeatMap(),
          const TextDivider(text: "Today's Schedule", icon: Icons.today),
          CustomizableButton(
            text: 'Start Workout',
            onButtonPress: () {
              print('Button clicked!');
            },
            onForwardPress: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Button clicked!')));
            },
            imageLocation: ImageIcons.dumbell,
          ),
          CustomProgressBarButton(
            text: '23% Calories Eaten',
            status: 23,
            onButtonPress: () {
              print('Progress button clicked!');
            },
          ),
        ],
      ),
    );
  }
}
