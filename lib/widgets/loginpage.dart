import 'package:flutter/material.dart';
import 'package:managment/Screens/login.dart';
import 'package:managment/Screens/regis.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoginForm = true;
  Map<String, String> _userCredentials = {};

  void _toggleForm() {
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  void _login(String username, String password) {
    if (_userCredentials.containsKey(username) &&
        _userCredentials[username] == password) {
      _showSnackbar('Login berhasil');
    } else {
      _showSnackbar('Login gagal. Coba lagi.');
    }
  }

  void _register(String username, String password) {
    if (!_userCredentials.containsKey(username)) {
      _userCredentials[username] = password;
      _showSnackbar('Registrasi berhasil');
      _toggleForm(); // Pindah ke tampilan login setelah registrasi berhasil
    } else {
      _showSnackbar('Username sudah terdaftar. Gunakan username lain.');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoginForm
          ? LoginScreen(onTap: _toggleForm, onLogin: _login)
          : RegisterScreen(onTap: _toggleForm, onRegister: _register),
    );
  }
}