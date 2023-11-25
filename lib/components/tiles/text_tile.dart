import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:workout_app/data/theme_provider.dart';

// ignore: must_be_immutable
class TextTile extends StatelessWidget {
  final VoidCallback onClick;
  final Row contents;
  final bool isSlideable;
  VoidCallback? onSettingsPress;
  VoidCallback? onDeletePress;
  TextTile({
    Key? key,
    required this.onClick,
    required this.contents,
    required this.isSlideable,
    this.onSettingsPress,
    this.onDeletePress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: isSlideable && onSettingsPress != null && onDeletePress != null
          ? Slidable(
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) => onSettingsPress!(),
                    backgroundColor: Colors.grey.shade800,
                    icon: Icons.settings,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  SlidableAction(
                    onPressed: (context) => onDeletePress!(),
                    backgroundColor: Colors.red.shade300,
                    icon: Icons.delete,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: onClick,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(30),
                  backgroundColor:
                      Provider.of<ThemeProvider>(context).getTileColor(),
                  foregroundColor:
                      Provider.of<ThemeProvider>(context).getChipcolor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: contents,
              ),
            )
          : TextButton(
              onPressed: onClick,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(30),
                backgroundColor:
                    Provider.of<ThemeProvider>(context).getTileColor(),
                foregroundColor:
                    Provider.of<ThemeProvider>(context).getChipcolor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: contents,
            ),
    );
  }
}
