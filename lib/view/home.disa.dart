import 'package:flutter/material.dart';
import 'package:p01/view/widgets/button.global.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:p01/utils/global.colors.dart';

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
      appBar: AppBar(
          backgroundColor: GlobalColors.mainColor,
          title: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
                height: 50,
                width: 50,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Eyes Up'),
              )
            ],
          ),
        ),
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
