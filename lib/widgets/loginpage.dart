import 'package:flutter/material.dart';
import 'package:managment/widgets/bottomnavigationbar.dart';
import 'package:managment/widgets/regisPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final gmailController = TextEditingController();
  final passwordController = TextEditingController();

  void _login(BuildContext context) {
    String gmail = gmailController.text;
    String pass = passwordController.text;

    String userGmail = 'user@gmail.com';
    String userPassword = '12345';

    if (gmail == userGmail && pass == userPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Bottom(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Login Failed'),
            content:
                const Text('Invalid Gmail or Password. Please try again...'),
            backgroundColor:Color.fromARGB(255, 221, 230, 237),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void _regis(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 82, 109, 130),
      body: Stack(
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
                      TextField(
                        controller: gmailController,
                        style: const TextStyle(
                          fontSize: 14,
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
                            color: Color.fromARGB(255, 39, 55, 77)
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 39, 55, 77)
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          _login(context);
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
                            _regis(context);
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
    );
  }
}
