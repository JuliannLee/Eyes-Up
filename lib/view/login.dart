import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p01/view/pickroles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/prov.dart';
import 'auth/auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginView> {
  AudioPlayer? audioPlayer;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool isAudioPlaying = true;
  String? userEmail;
  int? isTapped;
  late AuthFirebase auth;
  bool isSigningIn = false;
  bool _isMounted = false;

  @override
  void initState() {
    _isMounted = true;
    auth = AuthFirebase();
    audioPlayer = AudioPlayer();
    super.initState();
    checkIfLoggedIn();
  }

  @override
  void dispose() {
    _isMounted = false;
    stopAudio();
    super.dispose();
  }

  Future<void> playAudio() async {
    await audioPlayer?.play(AssetSource("audio/login.mp3"));
  }

  Future<void> playAudio2() async {
    await audioPlayer?.play(AssetSource("audio/logging_in.mp3"));
  }

  void stopAudio() {
    if (isAudioPlaying) {
      audioPlayer!.stop();
      if (_isMounted) {
        setState(() {
          isAudioPlaying = false;
        });
      }
    }
  }

  Future<void> checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!isLoggedIn) {
      playAudio();
    }

    if (_isMounted) {
      setState(() {
        isSigningIn = isLoggedIn;
      });
    }

    try {
      if (isLoggedIn) {
        playAudio2();
        await signInWithGoogle();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      if (_isMounted) {
        setState(() {
          isSigningIn = false;
        });
      }
    }
  }

  Future<String?> signInWithGoogle() async {
    if (_isMounted) {
      setState(() {
        isSigningIn = true;
      });
    }

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
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
        final userEmail = user.email ?? "Unknown";
        final firstName = user.displayName?.split(" ")[0];
        final lastName =
            user.displayName?.split(" ").sublist(1).join(" ");
        Provider.of<Prov>(context, listen: false).setUserEmail(userEmail);
        Provider.of<Prov>(context, listen: false)
            .setUserFirstName(firstName!);
        Provider.of<Prov>(context, listen: false)
            .setUserLastName(lastName!);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Roles()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      print(e.toString());
    } finally {
      if (_isMounted) {
        setState(() {
          isSigningIn = false;
        });
      }
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
            isSigningIn
                ? CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 400),
                      backgroundColor: Colors.blue.shade800,
                      padding: const EdgeInsets.all(10),
                      textStyle:
                          const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    onPressed: isSigningIn
                        ? null
                        : () async {
                            stopAudio();
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
