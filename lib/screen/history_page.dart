import 'package:flutter/material.dart';
import 'package:iot_dashboard/resources/model/DHT11DataTableSrc.dart';

import '../resources/model/DHT11Data.dart';
import '../resources/model/FilterModel.dart';
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
  bool isAscending = true;
  String isFilterSelected = 'All';

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
                  FilterView(
                    onAscendingPressed: () {
                      setState(() {
                        sortAscending();
                        isAscending = true;
                      });
                    },
                    onDescendingPressed: () {
                      setState(() {
                        sortDescending();
                        isAscending = false;
                      });
                    },
                    filters: [
                      FilterModel(
                          name: 'All',
                          isSelected: isFilterSelected == 'All',
                          onSelected: () {
                            setState(() {
                              isFilterSelected = 'All';
                              if (isAscending) {
                                sortAscending();
                              } else {
                                sortDescending();
                              }
                            });
                          }),
                      FilterModel(
                          name: 'Temperature',
                          isSelected: isFilterSelected == 'Temperature',
                          onSelected: () {
                            setState(() {
                              isFilterSelected = 'Temperature';
                              sortTemperature();
                            });
                          }),
                      FilterModel(
                          name: 'Humidity',
                          isSelected: isFilterSelected == 'Humidity',
                          onSelected: () {
                            setState(() {
                              isFilterSelected = 'Humidity';
                              sortHumidity();
                            });
                          }),
                      FilterModel(
                          name: 'Time',
                          isSelected: isFilterSelected == 'Time',
                          onSelected: () {
                            isFilterSelected = 'Time';
                            setState(() {
                              sortTime();
                            });
                          }),
                      FilterModel(
                          name: 'ID',
                          isSelected: isFilterSelected == 'ID',
                          onSelected: () {
                            isFilterSelected = 'ID';
                            setState(() {
                              if (isAscending) {
                                sortAscending();
                              } else {
                                sortDescending();
                              }
                            });
                          }),
                    ],
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
                  header: "Data Sensor",
                  columns: DHT11DataTableSrc.getColumn(),
                ),
              ),
            ],
          )),
    );
  }

  DHT11DataTableSrc<DHT11Data> search(String value) {
    DHT11DataTableSrc<DHT11Data> _data = DHT11DataTableSrc<DHT11Data>();
    for (var item in DataRepo.instance.listDHT11Data.read()) {
      if (isFilterSelected == 'All') {
        if (item.id.toString().contains(value) ||
            item.temperature.toString().contains(value) ||
            item.humidity.toString().contains(value) ||
            item.time.toString().contains(value)) {
          _data.create(item);
        }
      } else if (isFilterSelected == 'Temperature') {
        if (item.temperature.toString().contains(value)) {
          _data.create(item);
        }
      } else if (isFilterSelected == 'Humidity') {
        if (item.humidity.toString().contains(value)) {
          _data.create(item);
        }
      } else if (isFilterSelected == 'Time') {
        if (item.time.toString().contains(value)) {
          _data.create(item);
        }
      } else if (isFilterSelected == 'ID') {
        if (item.id.toString().contains(value)) {
          _data.create(item);
        }
      }
    }
    return _data;
  }

  void sortAscending() {
    if (isFilterSelected == 'Temperature') {
      data.read().sort((a, b) {
        return a.temperature.compareTo(b.temperature);
      });
    } else if (isFilterSelected == 'Humidity') {
      data.read().sort((a, b) {
        return a.humidity.compareTo(b.humidity);
      });
    } else if (isFilterSelected == 'Time') {
      data.read().sort((a, b) {
        return a.time.compareTo(b.time);
      });
    } else if (isFilterSelected == 'ID') {
      data.read().sort((a, b) {
        return a.id.compareTo(b.id);
      });
    } else {
      data.read().sort((a, b) {
        return a.id.compareTo(b.id);
      });
    }
    data.notifyListeners();
  }

  void sortDescending() {
    // Only used for answering A+ questions
    // printDusTodayBigger(50);
    if (isFilterSelected == 'Temperature') {
      data.read().sort((a, b) {
        return b.temperature.compareTo(a.temperature);
      });
    } else if (isFilterSelected == 'Humidity') {
      data.read().sort((a, b) {
        return b.humidity.compareTo(a.humidity);
      });
    } else if (isFilterSelected == 'Time') {
      data.read().sort((a, b) {
        return b.time.compareTo(a.time);
      });
    } else if (isFilterSelected == 'ID') {
      data.read().sort((a, b) {
        return b.id.compareTo(a.id);
      });
    } else {
      data.read().sort((a, b) {
        return b.id.compareTo(a.id);
      });
    }
    data.notifyListeners();
  }
  void sortTemperature() {
    if (isAscending) {
      data.read().sort((a, b) {
        return a.temperature.compareTo(b.temperature);
      });
    } else {
      data.read().sort((a, b) {
        return b.temperature.compareTo(a.temperature);
      });
    }
    data.notifyListeners();
  }

  void sortHumidity() {
    if (isAscending) {
      data.read().sort((a, b) {
        return a.humidity.compareTo(b.humidity);
      });
    } else {
      data.read().sort((a, b) {
        return b.humidity.compareTo(a.humidity);
      });
    }
    data.notifyListeners();
  }

  void sortTime() {
    if (isAscending) {
      data.read().sort((a, b) {
        return a.time.compareTo(b.time);
      });
    } else {
      data.read().sort((a, b) {
        return b.time.compareTo(a.time);
      });
    }
    data.notifyListeners();
  }

  void printMaxLightToday() {
    var max = 0.0;
    var time = DateTime.now();
    for (var item in data.read()) {
      if (item.time.day == time.day) {
        if (item.lux > max) {
          max = item.lux;
        }
      }
    }
    print(max);
  }

  void printMaxHumidityToday() {
    var max = 0.0;
    var time = DateTime.now();
    for (var item in data.read()) {
      if (item.time.day == time.day) {
        if (item.humidity > max) {
          max = item.humidity;
        }
      }
    }
    print(max);
  }

  void printDusTodayBigger(int value) {
    var time = DateTime.now();
    var list = [];
    for (var item in data.read()) {
      if (item.time.day == time.day) {
        if (item.dust > value) {
          list.add(item);
          print("${item.dust} ${item.time}");
        }
      }
    }
    print(list.length);
  }

  void printLightInLastMinute(int minute) {
    var time = DateTime.now();
    var count = 0;
    for (var item in data.read()) {
      if (item.time.day == time.day &&
          item.time.hour == time.hour &&
          item.time.minute > time.minute - minute) {
        count++;
      }
    }
    print(count);
  }
}
