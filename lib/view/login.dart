// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p01/view/auth/gmail.dart';
import 'package:audioplayers/audioplayers.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

<<<<<<< Updated upstream
class _LoginViewState extends State<LoginView> {
  String isTapped = '';
  late AudioPlayer audioPlayer;
=======
class _LoginState extends State<LoginView> {
  AudioPlayer? audioPlayer;
>>>>>>> Stashed changes

  @override
  void initState() {
    super.initState();
<<<<<<< Updated upstream
    audioPlayer = AudioPlayer();
    playAudio();
=======
    playAudio();
    checkLoginStatus();
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
=======
  Future<void> checkLoginStatus() async {
    final isLoggedIn = await login
        .isLoggedIn(); // Use the login class to check the login status
    if (isLoggedIn) {
      // If the user is already logged in, navigate to the HomeDisa page
      _navigateToHomeDisa(context);
    } else {
      audioPlayer = AudioPlayer();
      playAudio();
    }
  }

  void _navigateToHomeDisa(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Roles()),
      (Route<dynamic> route) => false,
    );
  }

>>>>>>> Stashed changes
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
                audioPlayer
                    .stop(); // Stop audio before switching to another page
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
