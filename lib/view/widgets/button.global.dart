// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:p01/utils/global.colors.dart';
import 'package:p01/view/login.dart';
import 'package:p01/view/pickroles.dart';
import 'package:p01/view/vc.dart';
import '../bottomnav.dart';
import 'package:permission_handler/permission_handler.dart';

class ButtonSign extends StatelessWidget {
  const ButtonSign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const Roles();
            },
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
            color: GlobalColors.mainColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              )
            ]),
        child: const Text(
          'Sign In',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class ButtonRegis extends StatelessWidget {
  const ButtonRegis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const LoginView();
            },
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
            color: GlobalColors.mainColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              )
            ]),
        child: const Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class ButtonVerif extends StatelessWidget {
  const ButtonVerif({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const LoginView();
            },
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
            color: GlobalColors.mainColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              )
            ]),
        child: const Text(
          'Send Verification Link',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class ButtonVolun extends StatelessWidget {
  final VoidCallback stopAudio;

  const ButtonVolun({Key? key, required this.stopAudio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        stopAudio(); // Stop the audio before navigating
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const MyHomePageV();
            },
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        height: 695,
        width: 180,
        padding: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
            color: GlobalColors.volunColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              )
            ]),
        child: const Text(
          "I'd like to volunteer",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 32),
        ),
      ),
    );
  }
}

class ButtonDisa extends StatelessWidget {
  final VoidCallback stopAudio;

  const ButtonDisa({Key? key, required this.stopAudio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        stopAudio(); // Stop the audio before navigating
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const MyHomePageD();
            },
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        height: 695,
        width: 180,
        padding: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
            color: GlobalColors.disaColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 1,
              )
            ]),
        child: const Text(
          'I need visual assistance',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 32),
        ),
      ),
    );
  }
}

class ButtonVCdisa extends StatelessWidget {
  const ButtonVCdisa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () async {
        bool hasPermission = await requestCameraPermission();

        if (!hasPermission) {
          // Handle the case where the user denied camera permission
          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const VCscreenDisa();
            },
          ),
        );
      },
      shape: const CircleBorder(),
      child: Image.asset(
        'assets/images/telpon.png',
        height: 280,
        width: 280,
      ),
    );
  }
}

Future<bool> requestCameraPermission() async {
  var status = await Permission.camera.status;

  if (status.isGranted) {
    return true; // Permission already granted
  }

  if (status.isPermanentlyDenied) {
    openAppSettings();
    return false; // Permission permanently denied, navigate to settings
  }

  var result = await Permission.camera.request();
  return result.isGranted;
}

class ButtonVCvolun extends StatelessWidget {
  const ButtonVCvolun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      key: const Key('buttonVCvolun'),
      onPressed: () async {
        bool hasPermission = await requestCameraPermission();

        if (!hasPermission) {
          // Handle the case where the user denied camera permission
          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const VCscreenVolun(
                key: const Key('vcScreenVolunKey')
              );
            },
          ),
        );
      },
      shape: const CircleBorder(),
      child: Image.asset(
        'assets/images/search.png',
        height: 255,
        width: 255,
      ),
    );
  }
}
