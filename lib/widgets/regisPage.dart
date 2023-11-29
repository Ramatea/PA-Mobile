import 'package:flutter/material.dart';
import 'package:managment/widgets/loginpage.dart';


class RegisPage extends StatefulWidget {

  RegisPage({Key? key}) : super(key: key);

  @override
  State<RegisPage> createState() => _RegisPageState();
}

class _RegisPageState extends State<RegisPage> {
  final name = TextEditingController();
  final gmail = TextEditingController();
  final pass = TextEditingController();
  final confirmPass = TextEditingController();

  void _login(BuildContext context) {
    // Add navigation logic to login page here
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
  void _register(BuildContext context) {
    if (pass == confirmPass) {
      // Registration successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      // Passwords do not match
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Registration Failed'),
            content: const Text('Passwords do not match. Please try again...'),
            backgroundColor: Color.fromARGB(255, 221, 230, 237),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 82, 109, 130),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100, left: 30, right: 30, bottom: 50),
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
           const SizedBox(height: 16),
                    TextField(
                      controller: name,
                      style: const TextStyle(
                        fontSize: 14, 
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 39, 55, 77)
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: gmail,
                      style: const TextStyle(
                        fontSize: 14, 
                      ),
                      decoration: const InputDecoration(
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
                      controller: pass,
                      style: const TextStyle(
                        fontSize: 14, 
                      ),
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 39, 55, 77)
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: confirmPass,
                      style: const TextStyle(
                        fontSize: 14, 
                      ),
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 39, 55, 77)
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        _register(context); // Call the register function
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 39, 55, 77),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Container(
                        height: 40,
                        width: 200,
                        child: const Center(
                          child: Text(
                            'Simpan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
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
                          _login(context);
                        },
                        child: const Column(
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "Sign in",
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
            top: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  ClipOval(
                    child: Container(
                      color: Color.fromARGB(255, 221, 230, 237),
                      padding: EdgeInsets.only(top : 2, bottom: 5, right: 5, left: 5),
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

