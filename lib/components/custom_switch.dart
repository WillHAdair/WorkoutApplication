import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/components/info_message.dart';

class CustomSwitch extends StatelessWidget {
  final String title;
  final String? extraInfo;
  final bool defaultValue;
  final Function onChangeMethod;

  const CustomSwitch({
    super.key,
    required this.title,
    this.extraInfo,
    required this.defaultValue,
    required this.onChangeMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        extraInfo != null
            ? Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                InfoMessageButton(message: extraInfo!),
              ],
            )
            : Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            activeTrackColor: Colors.blue,
            inactiveTrackColor: Colors.grey,
            value: defaultValue,
            onChanged: (bool newValue) {
              onChangeMethod(newValue);
            },
          ),
        ),
      ],
    );
  }
}
