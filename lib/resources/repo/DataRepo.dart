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

  // Only for read
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

  void _readDHT11Data() {
    _databaseReferenceDht11.onValue.listen((event) {
      final data = event.snapshot.value;
      listDHT11Data.clear();
      print(data);
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
