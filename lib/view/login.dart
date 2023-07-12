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
  // ignore: library_private_types_in_public_api
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String isTapped = '';
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    playAudio();
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
                audioPlayer.stop(); // Stop audio before switching to another page
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
