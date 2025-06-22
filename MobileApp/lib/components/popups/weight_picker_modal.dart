import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/utils/themes.dart';

class WeightPickerModal extends StatefulWidget {
  final double initialWeight;
  final String title;
  final String unit;
  final double minWeight;
  final double maxWeight;
  final int divisions;
  final Function(double) onWeightChanged;

  const WeightPickerModal({
    super.key,
    required this.initialWeight,
    this.title = 'Set Weight',
    this.unit = 'lbs',
    this.minWeight = 0,
    this.maxWeight = 100,
    this.divisions = 100,
    required this.onWeightChanged,
  });

  @override
  State<WeightPickerModal> createState() => _WeightPickerModalState();
}

class _WeightPickerModalState extends State<WeightPickerModal> {
  late double currentWeight;

  @override
  void initState() {
    super.initState();
    currentWeight = widget.initialWeight;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Dialog(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: themeProvider.getPopupBackgroundColor(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Set Weight (lbs)',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.getTextColor(),
                  ),
                ),
                const SizedBox(height: 20),
                Slider(
                  value: currentWeight,
                  min: widget.minWeight,
                  max: widget.maxWeight,
                  divisions: widget.divisions,
                  activeColor: themeProvider.primaryColor,
                  inactiveColor: themeProvider.getHeaderBackgroundColor(),
                  label: '${currentWeight.toStringAsFixed(1)} ${widget.unit}',
                  onChanged: (value) {
                    setState(() {
                      currentWeight = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  '${currentWeight.toStringAsFixed(1)} ${widget.unit}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onWeightChanged(currentWeight);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          themeProvider.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Set',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); // Close the modal
              },
              child: Icon(
                Icons.close,
                size: 24,
                color: themeProvider.closeButton,
              ),
            ),
          )
        ],
      ),
    );
  }
}
