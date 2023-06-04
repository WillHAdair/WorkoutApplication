import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPageContent extends StatefulWidget {
  @override 
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPageContent> {
  bool darkTheme = true;
  bool trackProgress = false;
  bool syncResults = false;

  onDarkThemeChange(bool newValue1) {
    setState(() {
      darkTheme = newValue1;
    });
  }
  
  onTrackProgressChange(bool newValue2) {
    setState(() {
      trackProgress = newValue2;
    });
  }

  onSynceResultsChange(bool newValue3) {
    setState(() {
      syncResults = newValue3;
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
            buildAccountOption(context, 'Change Password', ['basic 1', 'basic 2']),
            buildAccountOption(context, 'Content Settings', ['basic 2', 'basic 3']),
            buildAccountOption(context, 'Social', ['basic 4']),
            buildAccountOption(context, 'Language', ['basic 5', 'basic 6', 'basic 7']),
            buildAccountOption(context, 'Privacy', ['basic 8']),
            const SizedBox(height: 40),
            const Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text('Notifications', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))
              ],
            ),
            const Divider(height: 20, thickness:  1),
            const SizedBox(height: 10),
            buildNotificationOption('Theme Dark', darkTheme, onDarkThemeChange),
            buildNotificationOption('Account Active', trackProgress, onTrackProgressChange),
            buildNotificationOption('Opportunity', syncResults, onSynceResultsChange),
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

  Padding buildNotificationOption(String title, bool value, Function onChangeMethod) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600]
          )),
          Transform.scale(
              scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.blue,
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue) {
                onChangeMethod(newValue);
              },
            ),
          )
        ],
      ),
    );
  }

  GestureDetector buildAccountOption(BuildContext context, String title, List<String> options) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: options
                .map((option) => Text(option))
                .toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close')
                  )
              ],
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]
              )),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        ),
      ),
    );
  }
}
