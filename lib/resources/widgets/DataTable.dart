import 'package:flutter/material.dart';

class MyDataTable extends StatefulWidget {
  // create empty table
  DataTableSource data;
  final String header;

  /// The configuration and labels for the columns in the table.
  final List<DataColumn> columns;

  MyDataTable(
      {super.key,
      required this.data,
      required this.header,
      required this.columns});

  @override
  State<MyDataTable> createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(

      source: widget.data,
      header: Text(widget.header),
      columns: widget.columns,
      columnSpacing: 100,
      horizontalMargin: 10,
      rowsPerPage: 10,
      showCheckboxColumn: false,
    );
  }
}
