import 'package:flutter/material.dart';
import 'package:iot_dashboard/resources/model/DHT11DataTableSrc.dart';

import '../resources/model/DHT11Data.dart';
import '../resources/repo/DataRepo.dart';
import '../resources/widgets/DataTable.dart';
import '../resources/widgets/FilterView.dart';
import '../resources/widgets/SearchView.dart';

class DataSensorPage extends StatefulWidget {
  @override
  _DataSensorPageState createState() => _DataSensorPageState();
}

class _DataSensorPageState extends State<DataSensorPage> {
  DHT11DataTableSrc data = DataRepo.instance.listDHT11Data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
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
                data: data,
                header: "Data Sensor",
                columns: DHT11DataTableSrc.getColumn(),
              ),
            ],
          )),
    );
  }

  DHT11DataTableSrc<DHT11Data> search(String value) {
    DHT11DataTableSrc<DHT11Data> _data = DHT11DataTableSrc<DHT11Data>();
    for (var item in DataRepo.instance.listDHT11Data.read()) {
      if (item.id.toString().contains(value) ||
          item.temperature.toString().contains(value) ||
          item.humidity.toString().contains(value) ||
          item.time.toString().contains(value)) {
        _data.create(item);
      }
    }
    return _data;
  }


}
