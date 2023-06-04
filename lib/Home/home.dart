import 'package:flutter/material.dart';
import 'home_content.dart';
import 'package:workout_app/Workouts/workouts.dart';
import 'package:workout_app/Settings/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.titles}) : super(key: key);

  final List<String> titles;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  int _selectedIndex = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.titles[_selectedIndex]),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePageContent(counter: _counter, incrementCounter: _incrementCounter),
          WorkoutsPage(),
          const SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart),
            label: 'Workouts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
