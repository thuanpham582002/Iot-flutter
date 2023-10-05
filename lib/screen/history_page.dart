import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot_dashboard/resources/model/DHT11DataTableSrc.dart';

import '../resources/model/ActionDataTableSrc.dart';
import '../resources/repo/DataRepo.dart';
import '../resources/widgets/DataTable.dart';

class DataSensorPage extends StatefulWidget {
  @override
  _DataSensorPageState createState() => _DataSensorPageState();
}

class _DataSensorPageState extends State<DataSensorPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
          width: double.infinity,
          child: MyDataTable(
            data: DataRepo.instance.listDHT11Data,
            header: "Data Sensor",
            columns: DHT11DataTableSrc.getColumn(),
          )),
    );
  }
}

class DataSensorTable extends StatelessWidget {
  const DataSensorTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                'Id',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'TimeStamp',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Temperature',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Humidity',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Light',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
        rows: const <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text(
                '1',
              )),
              DataCell(Text(
                '10:00',
              )),
              DataCell(Text(
                '30',
              )),
              DataCell(Text(
                '50',
              )),
              DataCell(Text(
                '70',
              )),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text(
                '2',
              )),
              DataCell(Text(
                '12:00',
              )),
              DataCell(Text(
                '32',
              )),
              DataCell(Text(
                '52',
              )),
              DataCell(Text(
                '72',
              )),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text(
                '3',
              )),
              DataCell(Text(
                '12:00',
              )),
              DataCell(Text(
                '32',
              )),
              DataCell(Text(
                '52',
              )),
              DataCell(Text(
                '72',
              )),
            ],
          ),
        ],
      ),
    );
  }
}
