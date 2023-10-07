import 'package:flutter/material.dart';
import 'package:p01/view/home.disa.dart';
import 'package:p01/view/setting.dart';
import 'package:p01/view/community.disa.dart';
import 'package:p01/view/community.volun.dart';
import 'home.volun.dart';
import 'package:audioplayers/audioplayers.dart';

class MyHomePageV extends StatefulWidget {
  const MyHomePageV({Key? key}) : super(key: key);

  @override
  State<MyHomePageV> createState() => _MyHomePageVState();
}

class _MyHomePageVState extends State<MyHomePageV> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home'),
    Text('Community'),
    Text('Setting'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body = _widgetOptions.elementAt(_selectedIndex);
    switch (_selectedIndex) {
      case 0:
        body = HomeVolun();
        break;
      case 1:
        body = const CommunityVolu();
        break;
      case 2:
        body = const Setting();
        break;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: body,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor:
              Colors.black, // change the selected icon color to black
          unselectedItemColor: Colors.black.withOpacity(
              0.6), // change the unselected icon color to transparent black
        ),
      ),
    );
  }
}

class MyHomePageD extends StatefulWidget {
  const MyHomePageD({Key? key}) : super(key: key);

  @override
  State<MyHomePageD> createState() => _MyHomePageDState();
}

class _MyHomePageDState extends State<MyHomePageD> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home'),
    Text('Community'),
    Text('Setting'),
  ];

  late AudioPlayer audioPlayer;
  bool isAudioPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      await audioPlayer.play(AssetSource('audio/disabled.mp3'));
      isAudioPlaying = true;
    } else {
      // Stop audio when other pages are selected
      if (isAudioPlaying) {
        await audioPlayer.stop();
        isAudioPlaying = false;
      }
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = _widgetOptions.elementAt(_selectedIndex);
    switch (_selectedIndex) {
      case 0:
        body = const HomeDisa();
        break;
      case 1:
        body = const CommunityDisa();
        break;
      case 2:
        body = const Setting();
        break;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: body,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor:
              Colors.black, // change the selected icon color to black
          unselectedItemColor: Colors.black.withOpacity(
              0.6), // change the unselected icon color to transparent black
        ),
      ),
    );
  }
}
