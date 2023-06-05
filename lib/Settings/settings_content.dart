import 'package:workout_app/components/custom_widgets/CustomSwitch.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/components/custom_widgets/TextPopUp.dart';

class SettingsPageContent extends StatefulWidget {
  const SettingsPageContent({super.key});

  @override 
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPageContent> {
  bool darkTheme = true;
  bool trackProgress = false;
  bool syncResults = false;

  onDarkThemeChange(bool newTheme) {
    setState(() {
      darkTheme = newTheme;
    });
  }
  
  onTrackProgressChange(bool newProgress) {
    setState(() {
      trackProgress = newProgress;
    });
  }

  onSynceResultsChange(bool newSynced) {
    setState(() {
      syncResults = newSynced;
    });
  }
//Credit to Lirs Tech Tips: https://www.youtube.com/@lirstechtips5874 for the base of this settings page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            const Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text('Account', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            const Divider(height: 20, thickness:  1),
            const SizedBox(height: 10),
            TextPopUp(context: context, title: 'Content Settings', textOptions: const ['basic 2', 'basic 3']),
            TextPopUp(context: context, title: 'Social', textOptions: const ['basic 4']),
            TextPopUp(context: context, title: 'Language', textOptions: const ['basic 5', 'basic 6', 'basic 7']),
            TextPopUp(context: context, title: 'Privacy', textOptions: const ['basic 8']),
            const SizedBox(height: 40),
            const Row(
              children: [
                Icon(
                  Icons.notification_add,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text('Preferences', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            const Divider(height: 20, thickness:  1),
            const SizedBox(height: 10),
            CustomSwitch(title: 'Theme Dark', defaultValue: darkTheme, onChangeMethod: onDarkThemeChange),
            CustomSwitch(title: 'Account Active', defaultValue: trackProgress, onChangeMethod: onTrackProgressChange),
            CustomSwitch(title: 'Opportunity', defaultValue: syncResults, onChangeMethod: onSynceResultsChange),
            const SizedBox(height: 40),
            Center(
              child: OutlinedButton(
                style:  OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                    )
                ),
                onPressed: () {}, //TODO: Implement Functionality for Sign out
                child: const Text('Sign Out', style: TextStyle(
                  fontSize: 16, letterSpacing: 2.2, color: Colors.black
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
