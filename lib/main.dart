import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/pages/home_page.dart';

import 'data/workout_data.dart';

void main() async {
  
  await Hive.initFlutter();

  await Hive.openBox("workout_database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutData(),
      child: MaterialApp(
        debugShowCheckedModeBanner:  false,
        home: const HomePage(),
        theme: ThemeData(primarySwatch: Colors.green),
      ),
    );
  }
}

