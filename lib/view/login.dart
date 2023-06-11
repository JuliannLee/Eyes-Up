import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p01/view/auth/gmail.dart';

class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);

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
  _loginview createState() => _loginview();
}

class _loginview extends State<LoginView> {
  String istapped = '';

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
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(3000, 400),
                backgroundColor: Colors.blue.shade800,
                padding:const EdgeInsets.all(10),
                textStyle: const TextStyle(fontSize: 14, color: Colors.white)
              ),
              onPressed: () {
                showAccountDialog(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  FaIcon(FontAwesomeIcons.envelope,size: 50,),
                  Text(" | ",style: TextStyle(fontSize: 60)),
                  Text(
                    "PRESS HERE",
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
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
