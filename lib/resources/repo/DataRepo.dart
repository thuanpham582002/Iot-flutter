import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:iot_dashboard/resources/model/DHT11Data.dart';
import 'package:iot_dashboard/resources/model/DHT11DataTableSrc.dart';

import '../model/ActionDataTableSrc.dart';

class DataRepo {
  static DataRepo? _instance;

  static DataRepo get instance => _instance ??= DataRepo._internal();

  DataRepo._internal() {
    _readDHT11Data();
    _readActionData();
  }

  final DatabaseReference _databaseReferenceDht11 =
      FirebaseDatabase.instance.ref("dht11");
  final DatabaseReference _databaseReferenceAction =
      FirebaseDatabase.instance.ref("action");

  // variable for save data DHT11
  final DHT11DataTableSrc listDHT11Data = Get.put(DHT11DataTableSrc());

  // variable for save data Action
  final ActionDataTableSrc listActionData = Get.put(ActionDataTableSrc());

  Future<void> setAction(String action) async {
    await _databaseReferenceAction.set(action);
  }

  Future<void> setDHT11Data(DHT11Data data) async {
    await _databaseReferenceDht11.push().set(data.toJson());
  }

  void _readDHT11Data() {
    _databaseReferenceDht11.onValue.listen((event) {
      final data = event.snapshot.value;
      listDHT11Data.clear();

      if (data != null && data is Map<String, dynamic>) {
        List<DHT11Data> _listDHT11Data = [];
        data.forEach((key, value) {
          final Map<String, dynamic> dataMap = value as Map<String, dynamic>;
          // Tạo đối tượng DHT11Data từ dữ liệu Firebase
          final DHT11Data dht11Data = DHT11Data.fromJson(dataMap);
          _listDHT11Data.add(dht11Data);
        });
        // Sort lại dữ liệu theo thời gian
        // _listDHT11Data.sort((a, b) => a.time.compareTo(b.time));
        listDHT11Data.setData(_listDHT11Data);
      }

      print(listDHT11Data
          .read()
          .last); // In danh sách dữ liệu sau khi đã đọc từ Firebase
    });
  }

  void _readActionData() {
    _databaseReferenceAction.onValue.listen((event) {
      final data = event.snapshot.value;
      listActionData.clear();
      print(data);
    });
  }
}
