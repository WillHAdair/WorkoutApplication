import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/data/theme_provider.dart';

class OptionTile extends StatelessWidget {
  final VoidCallback onClick;

  const OptionTile({
    Key? key,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(8),
      child: TextButton(
        onPressed: onClick,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(30), 
          backgroundColor: Provider.of<ThemeProvider>(context).getTileColor(),
          foregroundColor: Provider.of<ThemeProvider>(context).getChipcolor(), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 30,
            ),
            Text(
              'Choose workout',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ), 
    );
  }
}