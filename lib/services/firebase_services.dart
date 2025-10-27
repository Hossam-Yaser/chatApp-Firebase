import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final String email;
  final String password;

  FirebaseServices({required this.email, required this.password});

  Future<void> registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> loginUser() async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
