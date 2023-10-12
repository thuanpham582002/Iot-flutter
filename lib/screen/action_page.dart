import 'dart:js_interop_unsafe';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_dashboard/resources/repo/DataRepo.dart';

import '../resources/model/ActionDataTableSrc.dart';
import '../resources/widgets/DataTable.dart';
import '../resources/widgets/FilterView.dart';
import '../resources/widgets/SearchView.dart';

class ActionPage extends StatefulWidget {
  const ActionPage({super.key});

  @override
  _ActionPageState createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  ActionDataTableSrc data = DataRepo.instance.listActionData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  FilterView(),
                ],
              ),
              SearchView(
                onSearchChanged: (value) {
                  setState(() {
                    data = search(value);
                  });
                },
              ),
              MyDataTable(
                data: DataRepo.instance.listActionData,
                header: "Actions",
                columns: ActionDataTableSrc.getColumn(),
              ),
            ],
          )),
    );
  }

  ActionDataTableSrc search(String value) {
    ActionDataTableSrc _data = ActionDataTableSrc();
    for (var item in DataRepo.instance.listActionData.read()) {
      if (item.id.toString().contains(value) ||
          item.statusFan.toString().contains(value) ||
          item.statusLed.toString().contains(value) ||
          item.time.toString().contains(value)) {
        _data.create(item);
      }
    }
    return _data;
  }
}

// The "soruce" of the table
class MyData extends DataTableSource {
  // Generate some made-up data
  final List<Map<String, dynamic>> _data = List.generate(
      200,
      (index) => {
            "id": index,
            "title": "Item $index",
            "price": Random().nextInt(10000)
          });

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['id'].toString())),
      DataCell(Text(_data[index]["title"])),
      DataCell(Text(_data[index]["price"].toString())),
    ]);
  }
}
