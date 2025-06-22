import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/models/storage/exercise.dart';
import 'package:workout_app/models/storage/past_schedule_day.dart';
import 'package:workout_app/models/storage/schedule_day.dart';
import 'package:workout_app/models/storage/user_profile.dart';
import 'package:workout_app/models/storage/workout.dart';
import 'package:workout_app/models/storage/workout_schedule.dart';
import 'package:workout_app/models/storage/workout_set.dart';
import 'package:workout_app/utils/settings.dart';
import 'package:workout_app/utils/themes.dart';
import 'package:workout_app/pages/navigation_page.dart';
import 'package:workout_app/utils/workouts.dart';
import 'package:workout_app/models/storage/settings.dart';
import 'package:workout_app/utils/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper.initialize([
    WorkoutScheduleSchema,
    ScheduleDaySchema,
    WorkoutSchema,
    PastScheduleDaySchema,
    ExerciseSchema,
    WorkoutSetSchema,
    UserProfileSchema,
    SettingsSchema,
  ]);
  debugPaintSizeEnabled = false;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<SettingsProvider>(create: (_) => SettingsProvider()),
        ChangeNotifierProvider<WorkoutsProvider>(create: (_) => WorkoutsProvider()),
      ],
      child: MaterialApp(
        home: const SettingsLoader(),
        // Optionally add theme, darkTheme, themeMode here
      ),
    );
  }
}

class SettingsLoader extends StatefulWidget {
  const SettingsLoader({super.key});

  @override
  State<SettingsLoader> createState() => _SettingsLoaderState();
}

class _SettingsLoaderState extends State<SettingsLoader> {
  late Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = Provider.of<SettingsProvider>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Sync theme with settings after loading
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Provider.of<ThemeProvider>(context, listen: false).syncWithSettings(context);
          });
          return const NavigationPage();
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
