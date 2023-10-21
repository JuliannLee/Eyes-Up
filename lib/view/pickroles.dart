// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:p01/view/widgets/button.global.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:p01/providers/shared.dart';

class Roles extends StatefulWidget {
  const Roles({Key? key}) : super(key: key);

  @override
  _RolesState createState() => _RolesState();
}

class _RolesState extends State<Roles> {
  final audioPlayer = AudioPlayer();
  bool isAudioPlaying = true;

  @override
  void initState() {
    login.setLoggedIn(true);
    super.initState();
    playAudio();
  }

  void playAudio() async {
    await audioPlayer.play(AssetSource('audio/pickroles.mp3'));
  }

  void stopAudio() {
    if (isAudioPlaying) {
      audioPlayer.stop();
      setState(() {
        isAudioPlaying = false;
      });
    }
  }

  @override
  void dispose() {
    stopAudio();
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
                  children: [
                    ButtonVolun(stopAudio: stopAudio),
                    ButtonDisa(stopAudio: stopAudio),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
