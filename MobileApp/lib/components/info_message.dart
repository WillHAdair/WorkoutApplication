import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/utils/themes.dart';

class InfoMessageButton extends StatelessWidget {
  final String message; // The info message to display

  const InfoMessageButton({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
      icon: Icon(Icons.info_outline, color: themeProvider.primaryColor),
      onPressed: () {
        _showInfoModal(context, themeProvider);
      },
    );
  }

  void _showInfoModal(BuildContext context, ThemeProvider themeProvider) {
    final RenderBox buttonBox = context.findRenderObject() as RenderBox;
    final Offset buttonPosition = buttonBox.localToGlobal(Offset.zero);

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              left: buttonPosition.dx - 100,
              top: buttonPosition.dy - 80,
              child: Material(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    // Popup container
                    Container(
                      width: 200, // Fixed width for the modal
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: themeProvider.getBackgroundColor(),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        message,
                        textAlign: TextAlign.center, // Center the text
                        style: TextStyle(
                          fontSize: 14,
                          color: themeProvider.getTextColor(),
                        ),
                      ),
                    ),
                    // Close button
                    Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(); // Close the popup
                        },
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: themeProvider.closeButton,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}