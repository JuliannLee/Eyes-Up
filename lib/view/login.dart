import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:p01/view/pickroles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth/auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginView> {
  AudioPlayer? audioPlayer;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String? userEmail;
  int? isTapped;
  late AuthFirebase auth;
  bool isSigningIn = false; // Add a flag to track sign-in progress

  @override
  void initState() {
    auth = AuthFirebase();
    super.initState();
    playAudio();
  }

  Future<void> playAudio() async {
    await audioPlayer?.play(AssetSource("audio/login.mp3"));
  }

  Future<String?> signInWithGoogle() async {
    setState(() {
      isSigningIn = true; // Set the flag when sign-in starts
    });

    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Navigate to the next screen or perform further actions
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Roles()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isSigningIn = false; // Reset the flag when sign-in is complete
      });
    }

    return null;
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
              onPressed: isSigningIn ? null : () async {
                await signInWithGoogle();
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
