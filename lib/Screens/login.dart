import 'package:flutter/material.dart';
import 'package:managment/Screens/profile.dart';
 // Import file ProfileScreen

class LoginScreen extends StatefulWidget {
  final VoidCallback onTap;
  final Function(String, String) onLogin;

  LoginScreen({required this.onTap, required this.onLogin});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isLoggedIn = false;
  String _errorMessage = ''; // Menambah variabel untuk menyimpan pesan kesalahan

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void _login() {
    String username = usernameController.text;
    String password = passwordController.text;

    // Memastikan username dan password tidak kosong
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Username dan password harus diisi.';
      });
      return;
    }

    // Memanggil fungsi onLogin dari parent widget
    widget.onLogin(username, password);

    // Cek apakah login berhasil (gantilah dengan logika sesuai kebutuhan)
    bool loginSuccess = true;

    if (loginSuccess) {
      setState(() {
        _isLoggedIn = true;
        _errorMessage = ''; // Reset pesan kesalahan jika berhasil login
      });

      // Pindah ke halaman profil jika berhasil login
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(username: username),
        ),
      );
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_isLoggedIn,
      child: Container(
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
              // Menampilkan pesan kesalahan jika ada
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _login,
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(78, 201, 223, 100),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Login',
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
                  'Belum punya akun? Daftar disini',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
