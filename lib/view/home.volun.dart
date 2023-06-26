// ignore: unnecessary_import
import 'package:flutter/material.dart';
import 'package:p01/view/widgets/button.global.dart';

// ignore: use_key_in_widget_constructors
class HomeVolun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFF4),
      body: Center(
        child: Stack(children: [
          Positioned(
            left: 0.0,
            top: 0.0,
            width: 255,
            height: 100,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          const Positioned(
              top: 15,
              left: 68,
              child: Text(
                'Albert Suhargo',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              )),
          const Positioned(
              top: 45,
              left: 53.0,
              child: Text(
                'member since Apr 2023',
                style: TextStyle(fontSize: 14, color: Colors.black),
              )),
          const Positioned(
              top: 72,
              left: 93.0,
              child: Text(
                'Indonesia',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    backgroundColor: Color(0xFF0E4189)),
              )),
          const Positioned(
              top: 120,
              left: 28.0,
              child: Text(
                'You will receive a notification \nwhen someone needs your help.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF0E4189),
                    fontWeight: FontWeight.w500),
              )),
          const ButtonVCvolun(),
          const Positioned(
            top: 435,
            left: 13,
            child: Text(
              'Click the button to start helping!',
              style: TextStyle(
                  color: Color(0xFF707D93),fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
        ]),
      ),
    );
  }
}
