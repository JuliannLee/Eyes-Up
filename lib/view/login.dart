import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:p01/view/auth/gmail.dart';
import 'package:p01/providers/shared.dart';
import 'package:p01/view/pickroles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pickroles.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginView> {
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    checkLoginStatus(); // Check login status when the widget is initialized
    audioPlayer = AudioPlayer();
    playAudio();
    super.initState();
  }

  Future<void> playAudio() async {
    await audioPlayer.play(AssetSource("audio/login.mp3"));
  }

  void showAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          content: GmailView(),
        );
      },
    );
  }

  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> checkLoginStatus() async {
  final isLoggedIn = await login.isLoggedIn(); // Use the login class to check the login status
  if (isLoggedIn) {
    // If the user is already logged in, navigate to the HomeDisa page
    _navigateToHomeDisa(context);
  }
}


  void _navigateToHomeDisa(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Roles()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "LOGIN",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(300, 400),
                backgroundColor: Colors.blue.shade800,
                padding: const EdgeInsets.all(10),
                textStyle: const TextStyle(fontSize: 14, color: Colors.white),
              ),
              onPressed: () {
                audioPlayer.stop();
                showAccountDialog(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  FaIcon(
                    FontAwesomeIcons.envelope,
                    size: 50,
                  ),
                  Text(" | ", style: TextStyle(fontSize: 60)),
                  Text(
                    "PRESS HERE",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blue.shade900,
    );
  }
}
