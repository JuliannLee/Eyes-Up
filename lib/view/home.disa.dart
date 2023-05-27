// ignore: unnecessary_import
import 'package:flutter/material.dart';
import 'package:p01/view/widgets/button.global.dart';


// ignore: use_key_in_widget_constructors
class HomeDisa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                  ButtonVC()
              ]
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
