import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/datetime/date_timedata.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/pages/Workouts/workout_day_page.dart';

import '../components/custom_tile.dart';
import '../components/sliding_tile.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({Key? key}) : super(key: key);

  @override
  TrackerPageState createState() => TrackerPageState();
}

class TrackerPageState extends State<TrackerPage> {
  DateTime today = DateTime.now();

  void daySelected(DateTime day, DateTime focusedDay) {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => WorkoutDayPage(date: focusedDay),
      )
    );
  }

  void goToSchedulePage() {

  }

  void editSchedule(String name) {

  }

  void deleteSchedule(String name) {

  }

  void addSchedule() {

  }

  @override
  Widget build (BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text('Workout Tracking'),
          centerTitle: true,
        ),
      body: ListView(
        children: [
          TableCalendar(
            locale: "en_US",
            rowHeight: 43,
            headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, today),
            focusedDay: today,
            firstDay: createDateTimeObject(Provider.of<WorkoutData>(context).getStartDate()),
            lastDay: today,
            onDaySelected: daySelected,
          ),
          const SizedBox(height: 10),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Icon(
                Icons.schedule,
                color: Colors.blue,
              ),
              SizedBox(width: 10),
              Text('Current schedule',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
            ],
          ),
          SlidingTile(
            text: value.getTrackerList()[0].name,
            onForwardPress: () => goToSchedulePage(),
            onSettingsPress: () => editSchedule(value.getTrackerList()[0].name),
            onDeletePress: () => deleteSchedule(value.getTrackerList()[0].name),
            imageLocation: dumbellImg,
          ),
          const SizedBox(height: 10),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Icon(
                Icons.update,
                color: Colors.blue,
              ),
              SizedBox(width: 10),
              Text('Other schedules',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
            ],
          ),
          CustomTile(
            text: 'View Schedules',
            onForwardPress: () => goToSchedulePage(),
          ),
        ],
      ),
      ),
    );
  }
}