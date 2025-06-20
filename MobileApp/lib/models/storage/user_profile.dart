import 'package:isar/isar.dart';

part 'user_profile.g.dart';

@Collection()
class UserProfile {
  Id id = Isar.autoIncrement;

  late double height;
  late double weight;
  late double maintenanceCalories;

  late DateTime lastUpdated;
}