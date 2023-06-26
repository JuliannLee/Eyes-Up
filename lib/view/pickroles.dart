import 'package:flutter/material.dart';
import 'package:p01/view/widgets/button.global.dart';
import 'package:audioplayers/audioplayers.dart';

class Roles extends StatefulWidget {
  const Roles({Key? key}) : super(key: key);

  @override
// ignore: library_private_types_in_public_api
  _RolesState createState() => _RolesState();
}

class _RolesState extends State<Roles> {
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    playAudio();
  }

  void playAudio() async {
    await audioPlayer.play(AssetSource('assets/audio/pickroles.mp3'));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [ButtonVolun(), ButtonDisa()]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
