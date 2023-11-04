// import 'package:flutter/material.dart';
// import 'package:p01/view/pickroles.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:p01/view/auth/addaccount.dart';
// import 'package:provider/provider.dart';
// import 'package:p01/providers/prov.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_login/flutter_login.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'auth.dart';
// class Gmail extends StatelessWidget {
//   const Gmail({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: GmailView(),
//     );
//   }
// }

// class GmailView extends StatefulWidget {
//   const GmailView({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _GmailViewState createState() => _GmailViewState();
// }

// class _GmailViewState extends State<GmailView> {
//   final GoogleSignIn googleSignIn = GoogleSignIn(); 
//   String? userEmail;
//   int? isTapped;
//   late AuthFirebase auth;

//   @override
//   void initState() {
//     super.initState();
//     auth = AuthFirebase();
//     // auth.getUser().then((value) {
//     //   if (value != null) {
//     //     final route = MaterialPageRoute(builder: (context) => HalamanUtama(wid: value.uid));
//     //     Navigator.pushReplacement(context, route);
//     //   }
//     // }).catchError((err) => print(err));
//   }

//   Future<String?> _loginuser(LoginData data) {
//   return auth.login(data.name, data.password).then((value) {
//     if (value != null) {
//       // final route = MaterialPageRoute(builder: (context) => HalamanUtama(wid: value));
//       // Navigator.pushReplacement(context, route);
//       return null; // Return null here as it's required for the FlutterLogin return type.
//     } else {
//       final snackBar = SnackBar(
//         content: const Text('Login Failed, User Not Found'),
//         action: SnackBarAction(
//           label: "OK",
//           onPressed: () {},
//         ),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       final route = MaterialPageRoute(builder: (context) => m7());
//       Navigator.of(context).pushReplacement(route);
//       return 'Login failed'; // Return an error message here.
//     }
//   });
//   }

//   Future<String?> _onSignup(SignupData data) {
//   return auth.signUp(data.name!, data.password!).then((value) {
//     if (value != null) {
//       final snackBar = SnackBar(
//         content: Text('Sign Up Successful'),
//         action: SnackBarAction(label: "OK", onPressed: () {}),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       return auth.getUser().then((value) {
//         MaterialPageRoute route;
//         // if (value != null) {
//         //   route = MaterialPageRoute(builder: (context) => HalamanUtama(wid: value.uid));
//         // } else {
//         //   route = MaterialPageRoute(builder: (context) => m7());
//         // }
//         // Navigator.pushReplacement(context, route);
//         return null; // Return null here as it's required for the FlutterLogin return type.
//       }).catchError((err) => print(err));
//     } else {
//       return 'Sign Up Failed'; // Return an error message here.
//     }
//   });
//   }
//   Future<String?> signInWithGoogle() async {
//   try {
//     final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//     final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleSignInAuthentication.accessToken,
//       idToken: googleSignInAuthentication.idToken,
//     );

//     final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
//     final User? user = userCredential.user;
    
//     // Use the user object for further operations or navigate to a new screen.
//   } catch (e) {
//     print(e.toString());
//   }
//   return null;
// }
//   @override
//   Widget build(BuildContext context) {
//     // final provData = Provider.of<Prov>(context);

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
            
//           ],
//         ),
//       ),
//       // backgroundColor: const Color.fromARGB(255, 218, 217, 217),
//     );
//   }
// }
