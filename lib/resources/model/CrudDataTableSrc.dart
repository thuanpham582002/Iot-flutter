import 'package:flutter/material.dart';

abstract class CrudDataTableSrc<T> extends DataTableSource {
  List<T> _data = <T>[];

  void create(T item) {
    _data.add(item);
    notifyListeners();
  }

  List<T> read() {
    return _data;
  }

  void update(T item) {
    _data[_data.indexOf(item)] = item;
    notifyListeners();
  }

  void delete(T item) {
    _data.remove(item);
    notifyListeners();
  }

  void clear() {
    _data.clear();
    notifyListeners();
  }

  void setData(List<T> data) {
    _data = data;
    notifyListeners();
  }


  @override
  bool get isRowCountApproximate => false;

  @override
// TODO: implement rowCount
  int get rowCount => _data.length;

  @override
// TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
