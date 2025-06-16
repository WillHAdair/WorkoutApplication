import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/utils/themes.dart';

class CustomProgressBarButton extends StatelessWidget {
  final String text;
  final double status;
  final VoidCallback onButtonPress;

  const CustomProgressBarButton({
    super.key,
    required this.text,
    required this.status,
    required this.onButtonPress,
  });

  // Determine the appropriate apple icon based on the status
  NutritionIcons getAppleIcon() {
    if (status <= 25) {
      return NutritionIcons.fullApple;
    } else if (status <= 50) {
      return NutritionIcons.bittenApple;
    } else if (status <= 75) {
      return NutritionIcons.halfApple;
    } else if (status <= 100) {
      return NutritionIcons.eatenApple;
    } else {
      return NutritionIcons.overEatenApple;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    final double clampedStatus = status.clamp(0, 100);

    final Color progressColor = status > 100
        ? Colors.red
        : Color.lerp(Colors.lightGreen, Colors.green[800], clampedStatus / 100)!;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: onButtonPress,
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: clampedStatus > 100 ? 1.0 : clampedStatus / 100,
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: progressColor,
                        borderRadius: clampedStatus < 100
                            ? const BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              )
                            : BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      nutritionIconPaths[getAppleIcon()]!,
                      height: 60,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      text,
                      style: TextStyle(
                        color: themeProvider.getTextColor(),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}