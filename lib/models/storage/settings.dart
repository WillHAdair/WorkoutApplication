import 'package:isar/isar.dart';
import 'package:workout_app/models/constants.dart';

part 'settings.g.dart';

@Collection()
class Settings {
  Id id = 1;

  bool isDarkMode = false;
  bool showLast30Days = false;
  
  @enumerated
  late ActivityTracker selectedOption;
}