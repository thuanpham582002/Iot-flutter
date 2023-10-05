import 'package:flutter/material.dart';

import 'CrudDataTableSrc.dart';

class ActionDataTableSrc<ActionData> extends CrudDataTableSrc {
  @override
  DataRow? getRow(int index) {
    final item = read()[index];
    return DataRow(cells: [
      DataCell(Text(item.id.toString())),
      DataCell(Text(item.statusFan.toString())),
      DataCell(Text(item.statusLed.toString())),
      DataCell(Text(item.time.toString())),
    ]);
  }

  static getColumn() {
    return [
      const DataColumn(label: Expanded(child: Text("ID"))),
      const DataColumn(label: Expanded(child: Text("Status Fan"))),
      const DataColumn(label: Expanded(child: Text("Status Led"))),
      const DataColumn(label: Expanded(child: Text("Time"))),
    ];
  }
}
