import 'package:firebase_auth/firebase_auth.dart';
class AuthFirebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<User?> getUser() async {
    User? user = _firebaseAuth.currentUser;
    return user;
  }
}
