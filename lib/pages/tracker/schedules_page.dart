import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/custom_tile.dart';
import 'package:workout_app/data/schedule_data.dart';
import 'package:workout_app/models/schedule.dart';
import 'package:workout_app/pages/tracker/schedule_page.dart';

class SchedulesPage extends StatefulWidget{ 

  const SchedulesPage({super.key});

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
    void goToSchedulePage(Schedule tracker) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SchedulePage(tracker: tracker)
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Schedules"),
          centerTitle: true,
        ),
        body: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: value.getSchedules().length,
          itemBuilder: (context, index) => CustomTile(
            text: value.getSchedules()[index].name, 
            onForwardPress: () => goToSchedulePage(value.getSchedules()[index]),
          ),
      ),
      ),
    );
  }
}