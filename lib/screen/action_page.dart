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
                  FilterView(
                    onAscendingPressed: () {
                      setState(() {
                        sortAscending();
                      });
                    },
                    onDescendingPressed: () {
                      setState(() {
                        sortDescending();
                      });
                    },
                  ),
                ],
              ),
              SearchView(
                onSearchChanged: (value) {
                  setState(() {
                    data = search(value);
                  });
                },
              ),
              Container(
                width: double.infinity,
                child: MyDataTable(
                  data: data,
                  header: "Actions",
                  columns: ActionDataTableSrc.getColumn(),
                ),
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

  void sortAscending() {
    data.read().sort((a, b) {
      return a.id.compareTo(b.id);
    });
    data.notifyListeners();
  }

  void sortDescending() {
    data.read().sort((a, b) {
      return b.id.compareTo(a.id);
    });
    data.notifyListeners();
  }
}
