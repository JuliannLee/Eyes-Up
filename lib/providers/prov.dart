import 'package:flutter/material.dart';

class Prov extends ChangeNotifier {
  String? userEmail;
  String? userFirstName;
  String? userLastName;
  final List _data = [];
  List get data => _data.toSet().toList();

  // ignore: non_constant_identifier_names
  set AddData(value) {
    _data.add(value);
    notifyListeners();
  }
  void setUserEmail(String email) {
    userEmail = email;
    notifyListeners();
  }
  void setUserFirstName(String firstName) {
    userFirstName = firstName;
    notifyListeners();
  }

  void setUserLastName(String lastName) {
    userLastName = lastName;
    notifyListeners();
  }
}
