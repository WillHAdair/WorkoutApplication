import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/utils/themes.dart';

class DurationPickerModal extends StatefulWidget {
  final int initialDurationInSeconds;
  final String title;
  final Function(int) onDurationChanged;

  const DurationPickerModal({
    super.key,
    required this.initialDurationInSeconds,
    this.title = 'Set Duration',
    required this.onDurationChanged,
  });

  @override
  State<DurationPickerModal> createState() => _DurationPickerModalState();
}

class _DurationPickerModalState extends State<DurationPickerModal> {
  late int hours;
  late int minutes;
  late int seconds;

  @override
  void initState() {
    super.initState();
    hours = widget.initialDurationInSeconds ~/ 3600;
    minutes = (widget.initialDurationInSeconds % 3600) ~/ 60;
    seconds = widget.initialDurationInSeconds % 60;
  }

  String _formatDuration(int hours, int minutes, int seconds) {
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
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
                  widget.title,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.getTextColor(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Hours',
                          style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.getTextColor(),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          width: 60,
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 50,
                            physics: const FixedExtentScrollPhysics(
                              parent: ClampingScrollPhysics(),
                            ),
                            controller: FixedExtentScrollController(
                              initialItem: hours,
                            ),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                hours = index;
                              });
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder:
                                  (context, index) => Center(
                                    child: Text(
                                      '$index',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: themeProvider.getTextColor(),
                                      ),
                                    ),
                                  ),
                              childCount: 6, // 0-5 hours
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Minutes',
                          style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.getTextColor(),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          width: 60,
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 40,
                            controller: FixedExtentScrollController(
                              initialItem: minutes,
                            ),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                minutes = index;
                              });
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder:
                                  (context, index) => Center(
                                    child: Text(
                                      '$index',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: themeProvider.getTextColor(),
                                      ),
                                    ),
                                  ),
                              childCount: 60, // 0-59 minutes
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Seconds',
                          style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.getTextColor(),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          width: 60,
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 40,
                            controller: FixedExtentScrollController(
                              initialItem: seconds,
                            ),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                seconds = index;
                              });
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                              builder:
                                  (context, index) => Center(
                                    child: Text(
                                      '$index',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: themeProvider.getTextColor(),
                                      ),
                                    ),
                                  ),
                              childCount: 60, // 0-59 seconds
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Selected: ${_formatDuration(hours, minutes, seconds)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.getTextColor(),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      final totalSeconds =
                          (hours * 3600) + (minutes * 60) + seconds;
                      widget.onDurationChanged(totalSeconds);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeProvider.primaryColor,
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
          ),
        ],
      ),
    );
  }
}
