import 'package:flutter/material.dart';
import 'package:workout_app/components/custom_textfield.dart';

class CustomizableDialog extends StatelessWidget {
  final List<CustomTextField> customTextFields;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const CustomizableDialog({
    Key? key,
    required this.customTextFields,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
          backgroundColor: Colors.grey[900],
          content: Container(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight - 100),
            child: SingleChildScrollView(
              child: ListBody(
                children: [
                  ...customTextFields.map((customTextField) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomTextField(
                        controller: customTextField.controller,
                        hintText: customTextField.hintText,
                        obscureText: customTextField.obscureText,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: onSave,
              color: Colors.black,
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            ),
            MaterialButton(
              onPressed: onCancel,
              color: Colors.black,
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}