import 'package:flutter/material.dart';

import 'CrudDataTableSrc.dart';

class ActionDataTableSrc<ActionData> extends CrudDataTableSrc {
  @override
  DataRow? getRow(int index) {
    final item = read()[index];
    return DataRow(cells: [
      DataCell(Text(item.id.toString())),
      DataCell(Text(item.device)),
      DataCell(Text(item.status.toString())),
      DataCell(Text(item.time.toString())),
    ]);
  }

  static getColumn() {
    return [
      const DataColumn(label: Expanded(child: Text("ID"))),
      const DataColumn(label: Expanded(child: Text("Device"))),
      const DataColumn(label: Expanded(child: Text("Status"))),
      const DataColumn(label: Expanded(child: Text("Time"))),
    ];
  }
}
