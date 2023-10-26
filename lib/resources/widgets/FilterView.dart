import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/FilterModel.dart';

class FilterView extends StatefulWidget {
  final Function(String)? onFilterChanged;

  final List<FilterModel>? filters;

  // on Ascending Button Pressed
  final Function()? onAscendingPressed;

  // on Descending Button Pressed
  final Function()? onDescendingPressed;

  const FilterView({
    super.key,
    this.onFilterChanged,
    this.onAscendingPressed,
    this.onDescendingPressed,
    this.filters,
  });

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          // Acending Button
          ElevatedButton(
              onPressed: widget.onAscendingPressed, child: Text('Ascending')),
          // Descending Button
          ElevatedButton(
              onPressed: widget.onDescendingPressed, child: Text('Descending')),
        ]),
        Row(
          children: (widget.filters ?? []).map((filter) {
            return ElevatedButton(
              onPressed: () {
                filter.toggle();
                widget.onFilterChanged?.call(filter.name);
                setState(() {

                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  filter.isSelected ? Colors.blue : Colors.grey,
                ),
              ),
              child: Text(filter.name),
            );
          }).toList(),
        ),
      ],
    );
  }

  void onPressed() {}
}
