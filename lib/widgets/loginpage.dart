import 'package:flutter/material.dart';
import 'package:managment/widgets/auth.dart';
import 'package:managment/widgets/bottomnavigationbar.dart';
import 'package:managment/widgets/regisPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;
  bool isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController gmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  auth _auth = auth(); 

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final email = gmailController.value.text;
    final password = passwordController.value.text;

    setState(() => _loading = true);

    try {
      // Cek login user
      await _auth.login(email, password);
      // Navigasi ke Page User
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Bottom()),
      ); 
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Login Error'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40), 
            ),
            content: const Text(
                'Email or Password is invalid. Please try again!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      print('Login Failed: $e');
    }
    setState(() => _loading = false);
  }

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    Color textColor= brightness == Brightness.dark ? Colors.black : Colors.white;
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 82, 109, 130),
      body: Form(
        key: _formKey,
        child : Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 150, left: 30, right: 30, bottom: 50),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color.fromARGB(255, 221, 230, 237),
                  ),
                  height: 600,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: gmailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Your Email';
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontSize: 14,
                              color: textColor,
                            ),
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                              labelText: 'Gmail',
                              labelStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 39, 55, 77),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Your Password';
                              }
                              return null;
                            },
                            obscureText: !isPasswordVisible,
                            style: TextStyle(
                              fontSize: 14,
                              color: textColor,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: _togglePasswordVisibility,
                                child: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                              label: const Text(
                                'Password',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 39, 55, 77),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          ElevatedButton(
                            onPressed: () {
                              handleSubmit();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 39, 55, 77),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Container(
                              height: 40,
                              width: 150,
                              child: const Center(
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RegisPage()),
                                );
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "Sign up",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    ClipOval(
                      child: Container(
                        color: Color.fromARGB(255, 221, 230, 237),
                        padding: EdgeInsets.all(5),
                        child: Image.asset(
                          'images/logo.png',
                          height: 150,
                          width: 150,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
