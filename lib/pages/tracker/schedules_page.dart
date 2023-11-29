import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/components/basic_widgets/custom_textfield.dart';
import 'package:workout_app/components/basic_widgets/text_divider.dart';
import 'package:workout_app/components/popups/customizable_dialog.dart';
import 'package:workout_app/components/popups/text_popup.dart';
import 'package:workout_app/components/tiles/sliding_tile.dart';
import 'package:workout_app/data/schedule_data.dart';
import 'package:workout_app/data/theme_provider.dart';
import 'package:workout_app/models/schedule.dart';
import 'package:workout_app/pages/tracker/schedule_page.dart';

class SchedulesPage extends StatefulWidget {
  const SchedulesPage({super.key});

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  final scheduleNameController = TextEditingController();
  void goToSchedulePage(Schedule tracker) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SchedulePage(tracker: tracker)),
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

  void deselectSchedule() {
    Provider.of<ScheduleData>(context, listen: false).deleteChosenSchedule();
    setState(() {});
  }

  void selectSchedule(Schedule schedule) {
    Provider.of<ScheduleData>(context, listen: false)
        .editChosenSchedule(schedule);
    setState(() {});
  }

  void save() {
    String newScheduleName = scheduleNameController.text;
    Provider.of<ScheduleData>(context, listen: false)
        .addSchedule(newScheduleName);
    Navigator.pop(context);
    clear();
    goToSchedulePage(Provider.of<ScheduleData>(context, listen: false)
        .getRelevantSchedule(newScheduleName));
  }

  void createSchedule() {
    showDialog(
        context: context,
        builder: (context) {
          return CustomizableDialog(customTextFields: [
            CustomTextField(
              controller: scheduleNameController,
              name: "Schedule Name",
              prefixIcon: Icons.fitness_center,
              inputType: TextInputType.name,
            ),
          ], onSave: save, onCancel: cancel);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Schedules"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: [
              const TextDivider(
                  text: 'Chosen schedule', icon: Icons.done_outline),
              value.getCurrentSchedule() != null
                  ? SlidingTile(
                      text: value.getCurrentSchedule()!.name,
                      onForwardPress: () =>
                          goToSchedulePage(value.getCurrentSchedule()!),
                      onSettingsPress: () =>
                          editSchedule(value.getCurrentSchedule()!.name),
                      onDeletePress: () =>
                          deleteSchedule(value.getCurrentSchedule()!.name),
                      isSelected: true,
                      onChanged: () => deselectSchedule(),
                    )
                  : const SizedBox.shrink(),
              const TextDivider(
                  text: 'Available schedules',
                  icon: Icons.format_list_bulleted),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getSchedules().length,
                itemBuilder: (context, index) => SlidingTile(
                  text: value.getSchedules()[index].name,
                  onForwardPress: () =>
                      goToSchedulePage(value.getSchedules()[index]),
                  onSettingsPress: () =>
                      editSchedule(value.getSchedules()[index].name),
                  onDeletePress: () =>
                      deleteSchedule(value.getSchedules()[index].name),
                  isSelected: false,
                  onChanged: () => selectSchedule(value.getSchedules()[index]),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createSchedule,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
