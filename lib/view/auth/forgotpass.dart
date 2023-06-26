// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:p01/view/auth/otp.dart';

class ForgotPass extends StatelessWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ForgotPassPage(),
    );
  }
}

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({Key? key}) : super(key: key);

  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 600,
              height: 680,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/images/google.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const Text(
                    "Account Recovery",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Recover Your Google Account",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Email or Phone',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email or phone number';
                              }
                              if (!_isEmailOrPhoneValid(value)) {
                                return 'Please enter a valid Gmail address or phone number';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Forgot Email'),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                // Navigate to another page or perform further actions
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const otpScreen(),
                                  ),
                                );
                              }
                            },
                            child: const Text('Continue'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 218, 217, 217),
    );
  }

  bool _isEmailOrPhoneValid(String input) {
    final RegExp emailRegex = RegExp(
       r'^[\w-]+(\.[\w-]+)*@(?:[Gg][Mm][Aa][Ii][Ll]\.[Cc][Oo][Mm])$',
    );
    final RegExp phoneRegex = RegExp(
      r'^[0-9]{10,}$',
    );
    return emailRegex.hasMatch(input) || phoneRegex.hasMatch(input);
  }
}
