import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:workout_app/data/theme_provider.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/datetime/date_timedata.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/tracker.dart';
import 'package:workout_app/pages/Workouts/workout_day_page.dart';
import 'package:workout_app/pages/tracker/schedule_page.dart';
import 'package:workout_app/pages/tracker/schedules_page.dart';

import '../../components/custom_tile.dart';
import '../../components/sliding_tile.dart';

class TrackerHomePage extends StatefulWidget {
  const TrackerHomePage({Key? key}) : super(key: key);

  @override
  TrackerHomePageState createState() => TrackerHomePageState();
}

class TrackerHomePageState extends State<TrackerHomePage> {
  DateTime today = DateTime.now();

  void daySelected(DateTime day, DateTime focusedDay) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutDayPage(date: focusedDay),
        ));
  }

  void goToSchedulePage(Tracker tracker) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SchedulePage(tracker: tracker)),
    );
  }

  void goToSchedulesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SchedulesPage()),
    );
  }

  void editSchedule(String name) {}

  void deleteSchedule(String name) {}

  void addSchedule() {}

  @override
  Widget build(BuildContext context) {
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
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: createDateTimeObject(
                  Provider.of<WorkoutData>(context).getStartDate()),
              lastDay: today,
              onDaySelected: daySelected,
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Icon(
                  Icons.schedule,
                  color: Provider.of<ThemeProvider>(context).secondaryColor,
                ),
                const SizedBox(width: 10),
                const Text('Current schedule',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            SlidingTile(
              text: value.getTrackerList()[0].name,
              onForwardPress: () => goToSchedulePage(value.getTrackerList()[0]),
              onSettingsPress: () =>
                  editSchedule(value.getTrackerList()[0].name),
              onDeletePress: () =>
                  deleteSchedule(value.getTrackerList()[0].name),
              imageLocation: dumbellImg,
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Icon(
                  Icons.update,
                  color: Provider.of<ThemeProvider>(context).secondaryColor,
                ),
                const SizedBox(width: 10),
                const Text('Other schedules',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            CustomTile(
              text: 'View Schedules',
              onForwardPress: () => goToSchedulesPage(),
            ),
          ],
        ),
      ),
    );
  }
}
