import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionPage extends StatefulWidget {
  @override
  _ActionPageState createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ActionTable(),
    );
  }
}

class ActionTable extends StatelessWidget {
  const ActionTable({super.key});

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
              'Fan',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Light Bulb',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('10:00')),
            DataCell(Text('On')),
            DataCell(Text('Off')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('11:00')),
            DataCell(Text('Off')),
            DataCell(Text('On')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('12:00')),
            DataCell(Text('On')),
            DataCell(Text('Off')),
          ],
        ),
      ],
    );
  }
}
