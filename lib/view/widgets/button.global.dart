// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:p01/utils/global.colors.dart';
import 'package:p01/view/login.dart';
import 'package:p01/view/pickroles.dart';
import 'package:p01/view/vc.dart';
import '../bottomnav.dart';


class ButtonSign extends StatelessWidget {
  const ButtonSign({ Key? key }) : super(key: key);

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
          ]
        ),
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
  const ButtonRegis({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context){
            return LoginView();
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
          ]
        ),
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
  const ButtonVerif({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context){
            return LoginView();
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
          ]
        ),
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
  const ButtonVolun({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
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
          ]
        ),
        child: const Text(
          "I'd like to volunteer",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 32
          ),
        ),
      ),
    );
  }
}

class ButtonDisa extends StatelessWidget {
  const ButtonDisa({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
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
              blurRadius: 10,
            )
          ]
        ),
        child: const Text(
          'I need visual assistance',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 32
          ),
        ),
      ),
    );
  }
}

class ButtonVCdisa extends StatelessWidget {
  const ButtonVCdisa({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
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
      child: Image.asset('assets/images/telpon.png',
      height: 280,
      width: 280,
      ),
    );
  }
}

class ButtonVCvolun extends StatelessWidget {
  const ButtonVCvolun({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 170),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const VCscreenVolun();
            },
          ),
        );
      },
      shape: const CircleBorder(),
      child: Image.asset('assets/images/search.png',
      height: 255,
      width: 255,
      ),
    );
  }
}