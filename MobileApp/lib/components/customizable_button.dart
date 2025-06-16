import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/utils/themes.dart';

class CustomizableButton extends StatelessWidget {
  final String text;
  final VoidCallback onButtonPress;
  final VoidCallback onForwardPress;
  final ImageIcons? imageLocation;
  final IconData? optionalIcon;

  const CustomizableButton({
    super.key,
    required this.text,
    required this.onButtonPress,
    required this.onForwardPress,
    this.imageLocation,
    this.optionalIcon,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: onButtonPress,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: themeProvider.buttonColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (imageLocation != null)
                SizedBox(
                  height: 40,
                  child: Image.asset(imageIconPaths[imageLocation]!),
                )
              else
                const SizedBox.shrink(),

              Expanded(
                child: Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              IconButton(
                icon: Icon(optionalIcon ?? Icons.arrow_forward_ios),
                onPressed: onForwardPress,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
