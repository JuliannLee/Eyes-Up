// ignore: unnecessary_import
import 'package:flutter/material.dart';
import 'package:p01/view/widgets/button.global.dart';
import 'package:p01/utils/global.colors.dart';

// ignore: use_key_in_widget_constructors
class HomeVolun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFF4),
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              height: 50,
              width: 50,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Eyes Up'),
            )
          ],
        ),
      ),
      body: Stack(children: <Widget>[
        Positioned(
          left: 75,
          top: 10,
          width: 250,
          height: 90,
          child: Container(
            width: 250,
            height: 90,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
        ),
        const Positioned(
          left: 140,
          top: 20,
            child: Text(
          'Albert Suhargo',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
        )),
        const Positioned(
          left: 125,
          top: 45,
            child: Text(
          'member since Apr 2023',
          style: TextStyle(fontSize: 14, color: Colors.black),
        )),
        const Positioned(
          left: 170,
          top: 70,
            child: Text(
          'Indonesia',
          style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              backgroundColor: Color(0xFF0E4189)),
        )),
        const Positioned(
          left: 100,
          top: 105,
            child: Text(
          'You will receive a notification \nwhen someone needs your help.',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              color: Color(0xFF0E4189),
              fontWeight: FontWeight.w500),
        )),
        const Center(
          child: ButtonVCvolun(),
        ),
        const Positioned(
          left: 75,
          top: 450,
          child: Text(
            'Click the button to start helping!',
            style: TextStyle(
                color: Color(0xFF707D93),
                fontSize: 17,
                fontWeight: FontWeight.w600),
          ),
        ),
      ]),
    );
  }
}
