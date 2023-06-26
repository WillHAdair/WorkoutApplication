import 'package:workout_app/models/constants.dart';

class Setting {
  String name;
  SettingType type;
  //Dynamic because setting could be a boolean, string, or color
  var value;

  Setting({
    required this.name,
    required this.type,
    required this.value,
  });
}
