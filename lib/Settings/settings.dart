import 'package:flutter/material.dart';
import 'settings_content.dart';
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: IndexedStack(
        children: [
          SettingsPageContent(),
        ],
      )
    );
  }
}