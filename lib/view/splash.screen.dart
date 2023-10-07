import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p01/utils/global.colors.dart';
import 'package:p01/view/getstart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p01/view/login.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Cek status pengguna pertama kali membuka aplikasi
    Future<void> checkFirstTimeUser() async {
      final prefs = await SharedPreferences.getInstance();
      final isFirstTimeUser = prefs.getBool('isFirstTimeUser');

      if (isFirstTimeUser == null || isFirstTimeUser == true) {
        // Jika pengguna pertama kali atau sudah logout, tampilkan halaman getstarted.dart
        await Future.delayed(const Duration(seconds: 2));
        prefs.setBool('isFirstTimeUser', false);
        Get.to(const OnboardingScreen());
      } else {
        // Jika bukan pengguna pertama kali, arahkan ke halaman beranda atau yang sesuai
        // Misalnya: Get.to(const HomeScreen());
        await Future.delayed(const Duration(seconds: 2));
        Get.to(const LoginView());
      }
    }

    checkFirstTimeUser();

    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/logo.png', height: 200, width: 200),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Eyes Up',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
