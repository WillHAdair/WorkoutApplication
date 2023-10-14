import 'package:hive/hive.dart';
import 'package:workout_app/models/constants.dart';

part 'setting.g.dart';

@HiveType(typeId: 79, adapterName: 'SettingAdapter')
class Setting {
  @HiveField(0)
  String name;

  @HiveField(1)
  bool isString;
  //Dynamic because setting could be a boolean, string, or color
  @HiveField(2)
  var value;

  Setting({
    required this.name,
    required this.isString,
    required this.value,
  });
}
