import 'package:flutter/material.dart';

class Prov extends ChangeNotifier {
  final List _data = [];
  List get data => _data.toSet().toList();

  // ignore: non_constant_identifier_names
  set AddData(value) {
    _data.add(value);
    notifyListeners();
  }
}
