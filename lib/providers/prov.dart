import 'package:flutter/material.dart';

class Prov extends ChangeNotifier {
  List _data = [];
  List get data => _data;

  set AddData(value) {
    _data.add(value);
    notifyListeners();
  }
}
