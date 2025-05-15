import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/custom_switch.dart';
import 'package:workout_app/components/info_message.dart';
import 'package:workout_app/utils/themes.dart';

class ActivitySettingsModal extends StatefulWidget {
  final bool showLast30Days;
  final String selectedOption;
  final Function(bool, String) onSave;

  const ActivitySettingsModal({
    super.key,
    required this.showLast30Days,
    required this.selectedOption,
    required this.onSave,
  });

  @override
  State<ActivitySettingsModal> createState() => _ActivitySettingsModalState();
}

class _ActivitySettingsModalState extends State<ActivitySettingsModal> {
  late bool showLast30Days;
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    showLast30Days = widget.showLast30Days;
    selectedOption = widget.selectedOption;
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
                  'Activity Settings',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.getTextColor(),
                  ),
                ),
                const SizedBox(height: 20),
                CustomSwitch(
                  title: 'Show last 30 days',
                  extraInfo:
                      'If you do not want to see the last 30 days of activity, you can turn this off.',
                  defaultValue: showLast30Days,
                  onChangeMethod: (bool newValue) {
                    setState(() {
                      showLast30Days = newValue;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Heatmap Display',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    InfoMessageButton(
                      message:
                          "This setting allows you to choose what is shown on the heatmap and customize how you want to visualize your activity.",
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: themeProvider.getDropdownBackgroundColor(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: selectedOption,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: themeProvider.getTextColor(),
                      ),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: themeProvider.getTextColor()),
                      dropdownColor: themeProvider.getDropdownBackgroundColor(),
                      underline: const SizedBox(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedOption = newValue!;
                        });
                      },
                      items: <String>[
                        'Workouts Completed',
                        'Exercises Completed',
                        'Calorie Goals Met',
                        'Workouts and Calories',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: themeProvider.getTextColor(),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onSave(showLast30Days, selectedOption);
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
                      'Update',
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
          // Close button
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
          ),
        ],
      ),
    );
  }
}
