import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidingTile extends StatefulWidget {
  final String text;
  final VoidCallback onForwardPress;
  final VoidCallback onSettingsPress;
  final VoidCallback onDeletePress;
  final String? imageLocation;
  final VoidCallback? onChanged;
  bool? isSelected;

  SlidingTile({
    Key? key,
    required this.text,
    required this.onForwardPress,
    required this.onSettingsPress,
    required this.onDeletePress,
    this.isSelected,
    this.imageLocation,
    this.onChanged,
  }) : super(key: key);

  @override
  State<SlidingTile> createState() => _SlidingTileState();
}

class _SlidingTileState extends State<SlidingTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => widget.onSettingsPress(),
              backgroundColor: Colors.grey.shade800,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: (context) => widget.onDeletePress(),
              backgroundColor: Colors.red.shade300,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: widget.imageLocation != null ? SizedBox(
              height: 40,
              child: Image.asset(widget.imageLocation!),
            ) : widget.onChanged != null ? Checkbox(
                    value: widget.isSelected!,
                    onChanged: (value) {
                      widget.onChanged!();
                      setState(() {
                        widget.isSelected = value!;
                      });
                    },
                  ) : const SizedBox.shrink(),
            title: Text(
              widget.text,
              style: const TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: widget.onForwardPress,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
