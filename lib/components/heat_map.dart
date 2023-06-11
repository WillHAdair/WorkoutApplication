import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:workout_app/datetime/date_timedata.dart';


class CustomHeatMap extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const CustomHeatMap({super.key, required this.datasets, required this.startDate});

  @override
  Widget build(BuildContext context) {
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
          -2: Colors.cyan.shade400, // Indicates Rest Days
          -1: Colors.red.shade300, // Reds indicate skipped days
          0: Colors.grey.shade400, // this is to stop the heat map automatically setting everything to red
          1: Colors.green.shade100,
          2: Colors.green.shade200,
          3: Colors.green.shade300,
          4: Colors.green.shade400,
          5: Colors.green.shade500,
          6: Colors.green.shade600,
          7: Colors.green.shade700,
          8: Colors.green.shade800,
          9: Colors.green.shade900,
        },     
      )
    );
  }
}