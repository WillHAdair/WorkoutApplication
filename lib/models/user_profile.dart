import 'package:isar/isar.dart';

part 'user_profile.g.dart';

@Collection()
class UserProfile {
  Id id = Isar.autoIncrement;

  late double height;
  late double weight;

  DateTime? lastUpdated;
}