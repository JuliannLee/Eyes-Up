import 'package:flutter/material.dart';
import 'package:p01/utils/global.colors.dart';
import 'package:p01/view/home.disa.dart';
import 'package:p01/view/setting.dart';
import 'package:p01/view/community.dart';
import 'home.volun.dart';


class MyHomePageV extends StatefulWidget {
  const MyHomePageV({super.key});

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
        body = Community();
        break;
      case 2:
        body = Setting();
        break;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalColors.mainColor,
          title: Row(
            children: [
              Image.asset('assets/images/logo.png',
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
              Colors.black, // ubah warna ikon yang dipilih menjadi hitam
          unselectedItemColor: Colors.black.withOpacity(
              0.6), // ubah warna ikon yang tidak dipilih menjadi hitam transparan
        ),
      ),
    );
  }
}

class MyHomePageD extends StatefulWidget {
  const MyHomePageD({super.key});

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
        body = const HomeDisa();
        break;
      case 1:
        body = Community();
        break;
      case 2:
        body = Setting();
        break;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: GlobalColors.mainColor,
          title: Row(
            children: [
              Image.asset('assets/images/logo.png',
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
              Colors.black, // ubah warna ikon yang dipilih menjadi hitam
          unselectedItemColor: Colors.black.withOpacity(
              0.6), // ubah warna ikon yang tidak dipilih menjadi hitam transparan
        ),
      ),
    );
  }
}