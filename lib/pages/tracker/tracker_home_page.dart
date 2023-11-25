import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:workout_app/components/basic_widgets/custom_textfield.dart';
import 'package:workout_app/components/popups/customizable_dialog.dart';
import 'package:workout_app/data/schedule_data.dart';
import 'package:workout_app/data/theme_provider.dart';
import 'package:workout_app/data/workout_data.dart';
import 'package:workout_app/datetime/date_timedata.dart';
import 'package:workout_app/models/constants.dart';
import 'package:workout_app/models/schedule.dart';
import 'package:workout_app/pages/Workouts/workout_day_page.dart';
import 'package:workout_app/pages/tracker/schedule_page.dart';
import 'package:workout_app/pages/tracker/schedules_page.dart';

import '../../components/tiles/custom_tile.dart';
import '../../components/tiles/sliding_tile.dart';

class TrackerHomePage extends StatefulWidget {
  const TrackerHomePage({Key? key}) : super(key: key);

  @override
  TrackerHomePageState createState() => TrackerHomePageState();
}

class TrackerHomePageState extends State<TrackerHomePage> {
  DateTime today = DateTime.now();
  final scheduleNameController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<ScheduleData>(context, listen: false).initializeScheduleList();
  }

  void daySelected(DateTime day, DateTime focusedDay) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutDayPage(date: focusedDay),
        ));
  }

  void goToSchedulePage(Schedule tracker) {
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

  void edit(String oldName) {
    String newScheduleName = scheduleNameController.text;
    Provider.of<ScheduleData>(context, listen: false)
        .changeScheduleName(oldName, newScheduleName);
    Navigator.pop(context);
    clear();
  }

  void editSchedule(String name) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomizableDialog(customTextFields: [
          CustomTextField(
            controller: scheduleNameController,
            name: "New Name",
            prefixIcon: Icons.settings,
            inputType: TextInputType.text,
          )
        ], onSave: () => edit(name), onCancel: cancel);
      },
    );
  }

  void delete(String name) {
    Provider.of<ScheduleData>(context, listen: false).deleteSchedule(name);
    Navigator.pop(context);
  }

  void cancel() {
    Navigator.pop(context);
  }

  void clear() {
    scheduleNameController.clear();
  }

  void deleteSchedule(String name) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16),
          backgroundColor: Colors.grey[900],
          content: SingleChildScrollView(
            child: Row(
              children: [
                const Text(
                  'Are you sure?',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 12),
                Flexible(
                  fit: FlexFit.loose,
                  child: MaterialButton(
                    onPressed: () => delete(name),
                    color: Provider.of<ThemeProvider>(context).rejectColor,
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  fit: FlexFit.loose,
                  child: MaterialButton(
                    onPressed: cancel,
                    color: Provider.of<ThemeProvider>(context).acceptColor,
                    child: const Text(
                      'No',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleData>(
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
              text: value.getSchedules()[0].name,
              onForwardPress: () => goToSchedulePage(value.getSchedules()[0]),
              onSettingsPress: () => editSchedule(value.getSchedules()[0].name),
              onDeletePress: () => deleteSchedule(value.getSchedules()[0].name),
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
