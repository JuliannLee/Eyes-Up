import 'package:flutter/material.dart';
import 'package:p01/view/widgets/button.global.dart';
import 'package:audioplayers/audioplayers.dart';

class HomeDisa extends StatefulWidget {
  const HomeDisa({Key? key}) : super(key: key);

  @override
  _HomeDisaState createState() => _HomeDisaState();
}

class _HomeDisaState extends State<HomeDisa> {
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    if (!audioPlayed) {
      playAudio();
      audioPlayed = true;
    }
  }

  void playAudio() async {
    await audioPlayer.play(AssetSource('audio/disabled.mp3'));
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFF4),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [ButtonVCdisa()],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool audioPlayed = false;
