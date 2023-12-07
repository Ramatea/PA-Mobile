import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> register(String email, String password, String confirmPass, String confPass) async {
    try {
      if (password != confirmPass) {
        throw 'Password dan confirm password tidak sesuai';
      }
      
      if (email.toLowerCase() == 'admin@gmail.com') {
        throw 'Email sudah digunakan';
      }

      final regisUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = regisUser.user;
      final uidPengguna = user?.uid;

      if (user != null) {
        await user.updateDisplayName(user.email!);
        print('User registered successfully with email: $email');

        // MENYIMPAN AKUN KE FIREBASE
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uidPengguna)
            .set({
          'email': email,
        });
      } else {
        throw 'User registration failed';
      }
    } catch (e) {
      print('Registrasi Error: $e');
      if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
        throw 'Email sudah digunakan.';
      } else {
        throw 'Registrasi Error: $e';
      }
    }
  }

  // UNTUK LOGIN
  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}