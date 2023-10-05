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
          ElevatedButton(onPressed: onPressed, child: Text('Ascending')),
          // Descending Button
          ElevatedButton(onPressed: onPressed, child: Text('Descending')),
        ]),
        Row(children: []),
      ],
    );
  }

  void onPressed() {}
}
