import 'package:flutter/material.dart';
import 'package:p01/view/pickroles.dart';
import 'package:p01/view/auth/createaccount.dart';
import 'package:p01/view/auth/forgotpass.dart';
import 'package:provider/provider.dart';
import 'package:p01/providers/prov.dart';
class AddAccount extends StatelessWidget {
  const AddAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginEmail(),
    );
  }
}

class LoginEmail extends StatefulWidget {
  const LoginEmail({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginEmailState createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

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
                    "Sign In",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Use Your Google Account",
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
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: "Email",
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!_isEmailValid(value)) {
                                return 'Please enter a valid Gmail address';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              // ignore: avoid_print
                              print('Forgot email? clicked');
                            },
                            child: const Text(
                              'Forgot email?',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  const Text.rich(
                    TextSpan(
                      text:
                          'Not your computer? Use Guest mode to sign in privately.',
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Learn more',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.bold
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ElevatedButton(
                          onPressed: () {
                           Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Register(),
                                ),
                              );
                          },
                          child: const Text('Create Account'),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPassword(emailController: _emailController),
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
  bool _isEmailValid(String email) {
    // Simple email validation using a regular expression
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@(?:[Gg][Mm][Aa][Ii][Ll]\.[Cc][Oo][Mm])$',
    );
    return emailRegex.hasMatch(email);
  }
}



class LoginPassword extends StatefulWidget {
  final TextEditingController emailController;

  const LoginPassword({Key? key, required this.emailController})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPasswordState createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<LoginPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
    bool _hidden = true;
void _toggle() {
  setState(() {
    _hidden = !_hidden;
  });
}
  
  @override
  Widget build(BuildContext context) {
    final provData = Provider.of<Prov>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 800,
              height: 680,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      'assets/images/google.png',
                      width: 200,
                      height: 100,
                    ),
                  ),
                  const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Choose Your Google Account",
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
                            controller: _passwordController,
                            obscuringCharacter: '*',
                            obscureText: _hidden,
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
                              if (value.length<6) {
                                return 'Please enter a password with 6 characters or more';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgotPass(),
                              ),
                            );
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  const Text.rich(
                    TextSpan(
                      text:
                          'Not your computer? Use Guest mode to sign in privately.',
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Learn more',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.bold
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
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            const name = "Testing";
                            final email = widget.emailController.text;
                              provData.AddData = {
                              "Name": name,
                              "Email": email,
                              };
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Roles(),
                              ),
                            );
                          }
                        },
                        child: const Text('Sign In'),
                      ),
                    ),
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