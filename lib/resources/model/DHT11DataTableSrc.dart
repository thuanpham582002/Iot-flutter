import 'package:flutter/material.dart';

import 'CrudDataTableSrc.dart';

class DHT11DataTableSrc<DHT11Data> extends CrudDataTableSrc {
  @override
  DataRow? getRow(int index) {
    final item = read()[index];
    return DataRow(cells: [
      DataCell(Text(item.id.toString())),
      DataCell(Text(item.temperature.toString())),
      DataCell(Text(item.humidity.toString())),
      DataCell(Text(item.lux.toString())),
      DataCell(Text(item.dust.toString())),
      DataCell(Text(item.time.toString())),
    ]);
  }

  static getColumn() {
    return [
      const DataColumn(label: Expanded(child: Text("ID"))),
      const DataColumn(label: Expanded(child: Text("Temperature"))),
      const DataColumn(label: Expanded(child: Text("Humidity"))),
      const DataColumn(label: Expanded(child: Text("Lux"))),
      const DataColumn(label: Expanded(child: Text("Dus"))),
      const DataColumn(label: Expanded(child: Text("Time"))),
    ];
  }
}
