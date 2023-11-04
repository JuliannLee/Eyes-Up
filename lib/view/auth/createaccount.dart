// import 'package:flutter/material.dart';
// import 'package:p01/view/auth/addaccount.dart';
// import 'package:p01/view/login.dart';
// import 'package:provider/provider.dart';
// import 'package:p01/providers/prov.dart';

// class Register extends StatelessWidget {
//   const Register({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: RegisterEmail(),
//     );
//   }
// }

// class RegisterEmail extends StatefulWidget {
//   const RegisterEmail({Key? key}) : super(key: key);
//   @override
//   // ignore: library_private_types_in_public_api
//   _RegisterEmailState createState() => _RegisterEmailState();
// }

// class _RegisterEmailState extends State<RegisterEmail> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   bool _hidden = true;
//   void _toggle() {
//     setState(() {
//       _hidden = !_hidden;
//     });
//   }

//   // ignore: unused_field
//   late String _pass;
//   double _strength = 0;
//   RegExp numReg = RegExp(r".*[0-9].*");
//   RegExp letterReg = RegExp(r".*[A-Za-z].*");
//   String _displayText = '';

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provData = Provider.of<Prov>(context);

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               width: 600,
//               height: 680,
//               color: Colors.white,
//               child: Column(
//                 children: <Widget>[
//                   Container(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Image.asset(
//                       'assets/images/google.png',
//                       width: 100,
//                       height: 50,
//                     ),
//                   ),
//                   const Text(
//                     "Sign Up",
//                     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                   ),
//                   const Text(
//                     "Create Your Google Account",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   const SizedBox(height: 10),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           TextFormField(
//                             controller: _nameController,
//                             decoration: const InputDecoration(
//                               hintText: 'Name',
//                               hintStyle: TextStyle(
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Please enter your name';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 10),
//                           TextFormField(
//                             controller: _emailController,
//                             decoration: const InputDecoration(
//                               hintText: 'Email',
//                               hintStyle: TextStyle(
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Please enter your email';
//                               }
//                               if (!_isEmailValid(value)) {
//                                 return 'Please enter a valid email address';
//                               }
//                               return null;
//                             },
//                             keyboardType: TextInputType.emailAddress,
//                             textInputAction: TextInputAction.next,
//                             textCapitalization: TextCapitalization.none,
//                           ),
//                           const SizedBox(height: 10),
//                           TextFormField(
//                             obscuringCharacter: '*',
//                             obscureText: _hidden,
//                             controller: _passwordController,
//                             decoration: InputDecoration(
//                               suffixIcon: IconButton(
//                                 icon: Icon(_hidden
//                                     ? Icons.visibility_off
//                                     : Icons.visibility),
//                                 onPressed: _toggle,
//                               ),
//                               labelText: 'Password',
//                               hintStyle: const TextStyle(
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             // ignore: body_might_complete_normally_nullable
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Please enter your password';
//                               } else if (value.length < 6) {
//                                 return 'Password is too short';
//                               } else {
//                                 null;
//                               }
//                             },
//                             onChanged: (value) => {
//                               if (value.isEmpty)
//                                 {
//                                   setState(() {
//                                     _strength = 0;
//                                   })
//                                 }
//                               else if (value.length < 6)
//                                 {
//                                   setState(() {
//                                     _strength = 1 / 4;
//                                     _displayText = 'Your password is too short';
//                                   })
//                                 }
//                               else if (value.length < 8)
//                                 {
//                                   setState(() {
//                                     _strength = 2 / 4;
//                                     _displayText =
//                                         'Your password is acceptable but not strong';
//                                   })
//                                 }
//                               else
//                                 {
//                                   if (!letterReg.hasMatch(value) ||
//                                       !numReg.hasMatch(value))
//                                     {
//                                       setState(() {
//                                         // Password length >= 8
//                                         // But doesn't contain both letter and digit characters
//                                         _strength = 3 / 4;
//                                         _displayText =
//                                             'Your password is strong';
//                                       })
//                                     }
//                                   else
//                                     {
//                                       // Password length >= 8
//                                       // Password contains both letter and digit characters
//                                       setState(() {
//                                         _strength = 1;
//                                         _displayText = 'Your password is great';
//                                       })
//                                     }
//                                 }
//                             },
//                           ),
//                           const SizedBox(height: 20),
//                           LinearProgressIndicator(
//                             value: _strength,
//                             backgroundColor: Colors.grey[300],
//                             color: _strength <= 1 / 4
//                                 ? Colors.red
//                                 : _strength == 2 / 4
//                                     ? Colors.yellow
//                                     : _strength == 3 / 4
//                                         ? Colors.blue
//                                         : Colors.green,
//                             minHeight: 15,
//                           ),
//                           Text(
//                             _displayText,
//                             style: const TextStyle(fontSize: 18),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const Text.rich(
//                     TextSpan(
//                       text:
//                           'Not your computer? Use Guest mode to sign in privately.',
//                       children: <TextSpan>[
//                         TextSpan(
//                           text: 'Learn more',
//                           style: TextStyle(
//                               color: Colors.lightBlue,
//                               fontWeight: FontWeight.bold),
//                           // Add onTap handler for privacy policy link if desired
//                         ),
//                       ],
//                     ),
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Flexible(
//                         flex: 1,
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 10.0),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const AddAccount(),
//                                 ),
//                               );
//                             },
//                             child: const Text('Already Have account?'),
//                           ),
//                         ),
//                       ),
//                       Flexible(
//                         flex: 1,
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 10.0),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 _formKey.currentState!.save();
//                                 // Access the form field values
//                                 final name = _nameController.text;
//                                 final email = _emailController.text;
//                                 provData.AddData = {
//                                 "Name": name,
//                                 "Email": email,
//                               };
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const LoginView(),
//                                   ),
//                                 );
//                               }
//                             },
//                             child: const Text('Create Account'),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       backgroundColor: const Color.fromARGB(255, 218, 217, 217),
//     );
//   }

//   bool _isEmailValid(String email) {
//     // Simple email validation using a regular expression
//     final RegExp emailRegex = RegExp(
//       r'^[\w-]+(\.[\w-]+)*@(?:[Gg][Mm][Aa][Ii][Ll]\.[Cc][Oo][Mm])$',
//     );
//     return emailRegex.hasMatch(email);
//   }
// }
