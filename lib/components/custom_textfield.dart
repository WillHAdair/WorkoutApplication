import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/data/theme_provider.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Provider.of<ThemeProvider>(context).secondaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Provider.of<ThemeProvider>(context).secondaryColor),
            ),
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(
                color: Provider.of<ThemeProvider>(context).secondaryColor)),
      ),
    );
  }
}
