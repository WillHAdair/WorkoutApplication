import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/utils/themes.dart';

class TextDivider extends StatelessWidget {
  final String text;
  final IconData icon;

  const TextDivider({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Stack(
          alignment: Alignment.center, // Center the text
          children: [
            // Icon on the left
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  icon,
                  color: Provider.of<ThemeProvider>(context).secondaryColor,
                ),
              ),
            ),
            // Centered Text
            Text(
              text,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Provider.of<ThemeProvider>(context).getTextColor()),
            ),
          ],
        ),
        const Divider(height: 10, thickness: 1),
        const SizedBox(height: 10),
      ],
    );
  }
}