import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/datetime/date_timedata.dart';

import '../data/theme_provider.dart';


class CustomHeatMap extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const CustomHeatMap({super.key, required this.datasets, required this.startDate});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final Color restDayColor = themeProvider.restDayColor;
    final Color skipDayColor = themeProvider.skipDayColor;
    final MaterialColor heatMapColor = themeProvider.heatMapBaseColor;
    
    return Container(
      padding: const EdgeInsets.all(25),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(const Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[200],
        textColor: Colors.white,
        showColorTip: false,
        showText: true,
        scrollable: true,
        colorsets: {
          -2: restDayColor, // Indicates Rest Days
          -1: skipDayColor, // Reds indicate skipped days
          0: Colors.grey.shade400, // this is to stop the heat map automatically setting everything to red
          1: heatMapColor.shade100,
          2: heatMapColor.shade200,
          3: heatMapColor.shade300,
          4: heatMapColor.shade400,
          5: heatMapColor.shade500,
          6: heatMapColor.shade600,
          7: heatMapColor.shade700,
          8: heatMapColor.shade800,
          9: heatMapColor.shade900,
        },     
      )
    );
  }
}