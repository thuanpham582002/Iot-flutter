import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataSensorPage extends StatefulWidget {
  @override
  _DataSensorPageState createState() => _DataSensorPageState();
}

class _DataSensorPageState extends State<DataSensorPage> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataSensorTable(),
    );
  }
}

class DataSensorTable extends StatelessWidget {
  const DataSensorTable({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
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
            DataCell(Text('10:00')),
            DataCell(Text('30')),
            DataCell(Text('50')),
            DataCell(Text('70')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('11:00')),
            DataCell(Text('31')),
            DataCell(Text('51')),
            DataCell(Text('71')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('32')),
            DataCell(Text('52')),
            DataCell(Text('72')),
          ],
        ),
      ],
    );
  }
}
