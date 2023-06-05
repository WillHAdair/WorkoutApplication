import 'package:flutter/material.dart';

class TextPopUp extends StatelessWidget {
  final BuildContext context;
  final String title;
  final List<String> textOptions;

  const TextPopUp({
    super.key,
    required this.context,
    required this.title,
    required this.textOptions,
  });
  
  @override 
  Widget build(BuildContext context) {
     return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: textOptions
                .map((option) => Text(option))
                .toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close')
                  )
              ],
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]
              )),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        ),
      ),
    );   
  }
}