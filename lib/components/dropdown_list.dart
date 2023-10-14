import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/theme_provider.dart';

class SetData {
  final int reps;
  final double weight;
  SetData({required this.reps, required this.weight});
}

class DropdownList extends StatefulWidget {
  final String title;
  final List<SetData> sets;
  final bool isCompleted;

  const DropdownList({Key? key, required this.title, required this.sets, required this.isCompleted}) : super(key: key);

  @override
  _DropdownListState createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  bool isDropdownOpen = false;
  @override
  Widget build(BuildContext context) { 
    Color tileColor = Provider.of<ThemeProvider>(context).getTileColor();
    Color chipColor = Provider.of<ThemeProvider>(context).getChipcolor();
    if (widget.isCompleted) {
      tileColor = Provider.of<ThemeProvider>(context).tileCompleted;
      chipColor = Provider.of<ThemeProvider>(context).chipCompleted;
    }
    return Column(
      children: [
        ListTile(
          title: Text(widget.title),
          trailing: IconButton(
            icon: Icon(
              isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            ),
            onPressed: () {
              setState(() {
                isDropdownOpen = !isDropdownOpen;
              });
            },
          ),
        ),
        if (isDropdownOpen)
          Column(
            children: widget.sets
                .map((setData) => ListTile(
                      title: Text('Reps: ${setData.reps}, Weight: ${setData.weight}'),
                    ))
                .toList(),
          ),
      ],
    );
  }
}
