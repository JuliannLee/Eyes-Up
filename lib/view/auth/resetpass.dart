import 'package:flutter/material.dart';
import 'package:p01/view/auth/addaccount.dart';

class resetPassword extends StatefulWidget {
  const resetPassword({Key? key}) : super(key: key);

  @override
  State<resetPassword> createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();

  bool _hidden = true;
void _toggle() {
  setState(() {
    _hidden = !_hidden;
  });
}

late String _pass;
  double _strength = 0;
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");
  String _displayText = '';

  // ignore: prefer_typing_uninitialized_variables
  var confirmPass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      height: 50,
                    ),
                  ),
                  const Text(
                    "Change Password",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Create a strong password",
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
                            obscuringCharacter: '*',
                            obscureText: _hidden,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(_hidden ? Icons.visibility_off : Icons.visibility),
                                onPressed: _toggle,
                              ),
                              labelText: 'Password',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            validator: (value) {
                              confirmPass = value;
                              if (value!.isEmpty) {
                                return 'Please enter your new Password';
                              } else if (value.length < 6) {
                                return 'Password must have 6 characters!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            obscuringCharacter: '*',
                            obscureText: _hidden,
                            controller: _passwordConfirmController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(_hidden ? Icons.visibility_off : Icons.visibility),
                                onPressed: _toggle,
                              ),
                              labelText: 'Confirm Password',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              else if(value.length<6){
                                return 'Password is too short';
                              }
                              else if(value != confirmPass){
                                  return 'Password doesn\'t match!';
                                }
                              else {
                                null;
                              }
                            },
                            onChanged:(value) => {
                              if (value.isEmpty) {
                              setState(() {
                                _strength = 0;
                              })
                            } else if (value.length < 6) {
                              setState(() {
                                _strength = 1 / 4;
                                _displayText = 'Your password is too short';
                              })
                            } else if (value.length < 8) {
                              setState(() {
                                _strength = 2 / 4;
                                _displayText = 'Your password is acceptable but not strong';
                              })
                            } else {
                              if (!letterReg.hasMatch(value) || !numReg.hasMatch(value)) {
                                setState(() {
                                  // Password length >= 8
                                  // But doesn't contain both letter and digit characters
                                  _strength = 3 / 4;
                                  _displayText = 'Your password is strong';
                                })
                              } else {
                                // Password length >= 8
                                // Password contains both letter and digit characters
                                setState(() {
                                  _strength = 1;
                                  _displayText = 'Your password is great';
                                })
                                }}
                              },
                          ),
                          const SizedBox(height: 20),
                          LinearProgressIndicator(
                        value: _strength,
                        backgroundColor: Colors.grey[300],
                        color: _strength <= 1 / 4
                            ? Colors.red
                            : _strength == 2 / 4
                            ? Colors.yellow
                            : _strength == 3 / 4
                            ? Colors.blue
                            : Colors.green,
                        minHeight: 15,
                      ),
                      Text(
                        _displayText,
                        style: const TextStyle(fontSize: 18),
                      ),
                        ],
                      ),
                    ),
                  ),
                  const Text.rich(
                    TextSpan(
                      text: 'Not your computer? Use Guest mode to sign in privately.',
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Learn more',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.bold,
                          ),
                          // Add onTap handler for privacy policy link if desired
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AddAccount(),
                                  ),
                                );
                              }
                            },
                            child: const Text('Save Password'),
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
}
