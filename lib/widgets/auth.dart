import 'package:firebase_auth/firebase_auth.dart';

class auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register(String name, String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _auth.currentUser?.updateDisplayName(name);
      print('Registration successful.');
    } catch (e) {
      print('Error during registration: $e');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Login successful.');
    } catch (e) {
      print('Error during login: $e');
    }
  }
}
