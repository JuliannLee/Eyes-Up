import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p01/view/auth/gmail.dart';
 
// ignore: camel_case_types
class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);
 
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginView(),
    );
  }
}
 
// ignore: camel_case_types
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
 
  @override
// ignore: library_private_types_in_public_api
  _loginview createState() => _loginview();
}
 
// ignore: camel_case_types
class _loginview extends State<LoginView> {
  String istapped = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold)),
            const SizedBox(height: 20,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(3000, 400),
                    backgroundColor: Colors.blue.shade800,
                    padding:const EdgeInsets.all(10),
                    textStyle: const TextStyle(fontSize: 14, color: Colors.white)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GmailView()),
                    );
                },
                child: Row(mainAxisAlignment: MainAxisAlignment.center,children: const <Widget>[
                  FaIcon(FontAwesomeIcons.envelope,size: 50,),
                  Text(" | ",style: TextStyle(fontSize: 60)),
                  Text("PRESS HERE",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                ],)),
          ],
        ),
      ),
      backgroundColor: Colors.blue.shade900,
    );
  }
}