import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final String text;
  final VoidCallback onForwardPress;
  final String? imageLocation;
  final IconData? optionalIcon;

  const CustomTile({
    Key? key,
    required this.text,
    required this.onForwardPress,
    this.imageLocation,
    this.optionalIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: imageLocation != null ? SizedBox(
              height: 40,
              child: Image.asset(imageLocation!),
            ) : const SizedBox.shrink(),
            title: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              icon: Icon(optionalIcon ?? Icons.arrow_forward_ios),
              onPressed: onForwardPress,
              color: Colors.white,
            ),
          ),
        ),
    );
  }
}
