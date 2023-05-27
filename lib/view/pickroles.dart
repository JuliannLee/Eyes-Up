import 'package:flutter/material.dart';
import 'package:p01/view/widgets/button.global.dart';

class Roles extends StatelessWidget {
  const Roles({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                  ButtonVolun(),
                  ButtonDisa()
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