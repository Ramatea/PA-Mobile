import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onTap;
  final Function(String, String) onRegister;

  RegisterScreen({required this.onTap, required this.onRegister});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void _register() {
    String username = usernameController.text;
    String password = passwordController.text;
    widget.onRegister(username, password);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(78, 201, 223, 100),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.phone_android,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              'WalletWhizz',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: _toggleObscure,
                ),
              ),
              obscureText: _isObscure,
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _register,
              child: Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(78, 201, 223, 100),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: widget.onTap,
              child: Text(
                'Sudah punya akun? Login disini',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}