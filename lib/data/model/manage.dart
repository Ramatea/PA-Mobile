import 'package:flutter/foundation.dart';

class DataManage with ChangeNotifier {
  static final DataManage _instance = DataManage._internal();
  factory DataManage() {
    return _instance;
  }
  DataManage._internal();

  double _initialBalance = 100000000;
  final List<Map<String, dynamic>> _data = [];

  void addData(Map<String, dynamic> data) {
    _data.add(data);
    notifyListeners();
  }

  List<Map<String, dynamic>> get dataManage => _data;

  double get currentBalance => _initialBalance - totalExpend();

  double totalExpend() {
    double total = 0;
    for (var data in _data) {
      if (data['IN'] == 'Expend') {
        total += data['amount'];
      }
    }
    return total;
  }

  double totalIncome() {
    double total = 0;
    for (var data in _data) {
      if (data['IN'] == 'Income') {
        total += data['amount'];
      }
    }
    return total;
  }

  double totalBalance() {
    return _initialBalance + totalIncome() - totalExpend();
  }
}
