// ignore: unnecessary_import
import 'package:flutter/material.dart';
import 'package:p01/view/widgets/button.global.dart';
import 'package:audioplayers/audioplayers.dart';

// ignore: use_key_in_widget_constructors
class HomeDisa extends StatefulWidget {
  const HomeDisa({Key? key}) : super(key: key);

  @override
// ignore: library_private_types_in_public_api
  _HomeDisaState createState() => _HomeDisaState();
}

class _HomeDisaState extends State<HomeDisa> {
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    playAudio();
  }

  void playAudio() async {
    await audioPlayer.play(AssetSource('assets/audio/disabled.mp3'));
  }

  @override
  void dispose() {
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
                  children: const [
                  ButtonVCdisa()
              ]
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
