import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/activity_settings_modal.dart';
import 'package:workout_app/utils/settings.dart';
import 'package:workout_app/utils/themes.dart';

class FitnessHeatMap extends StatelessWidget {
  const FitnessHeatMap({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final settingsProvider = Provider.of<SettingsProvider>(context);

    // Dynamically calculate the start and end dates based on `showLast30Days`
    final DateTime endDate = DateTime.now();
    final DateTime startDate = settingsProvider.showLast30Days
        ? endDate.subtract(const Duration(days: 30))
        : endDate.subtract(const Duration(days: 45));

    return Container(
      padding: const EdgeInsets.all(20),
      color: themeProvider.getHeatmapBackgroundColor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: themeProvider.getHeaderBackgroundColor(),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Activity Heatmap',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.getTextColor(),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  color: themeProvider.getTextColor(),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ActivitySettingsModal(
                          showLast30Days: settingsProvider.showLast30Days,
                          selectedOption: settingsProvider.selectedOption,
                          onSave: (bool newShowLast30Days, String newSelectedOption) async {
                            await settingsProvider.setShowLast30Days(newShowLast30Days);
                            await settingsProvider.setSelectedOption(newSelectedOption);
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          HeatMap(
            datasets: {
              DateTime(2025, 5, 1): 1,
              DateTime(2025, 5, 2): 2,
              DateTime(2025, 5, 3): 3,
              DateTime(2025, 5, 4): 1,
              DateTime(2025, 5, 5): 8,
            },
            colorMode: ColorMode.color,
            textColor: themeProvider.getTextColor(),
            defaultColor: themeProvider.getHeatMapBaseColor(),
            startDate: startDate, // Dynamically set start date
            endDate: endDate, // Dynamically set end date
            showText: false,
            scrollable: true,
            size: 35,
            showColorTip: false,
            colorsets: {
              1: themeProvider.heatMapColor.shade100,
              2: themeProvider.heatMapColor.shade200,
              3: themeProvider.heatMapColor.shade300,
              4: themeProvider.heatMapColor.shade400,
              5: themeProvider.heatMapColor.shade500,
              6: themeProvider.heatMapColor.shade600,
              7: themeProvider.heatMapColor.shade700,
              8: themeProvider.heatMapColor.shade800,
              9: themeProvider.heatMapColor.shade900,
            },
            onClick: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(value.toString()),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}