import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/data/theme_provider.dart';

class TextDivider extends StatelessWidget {
  final String text;
  final IconData icon;

  const TextDivider({
    super.key,
    required this.text, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Row(
          children: [
            const SizedBox(width: 10),
            Icon(
              icon,
              color: Provider.of<ThemeProvider>(context).secondaryColor,
            ),
            const SizedBox(width: 10),
            Text(text, 
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold) 
            ),
          ],
        ),
        const Divider(height: 10, thickness: 1),
        const SizedBox(height: 10,),
      ],
    );
  }
}