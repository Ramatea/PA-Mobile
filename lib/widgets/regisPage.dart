import 'package:flutter/material.dart';
import 'package:managment/widgets/auth.dart';
import 'package:managment/widgets/loginpage.dart';

class RegisPage extends StatefulWidget {
  RegisPage({Key? key}) : super(key: key);

  @override
  State<RegisPage> createState() => _RegisPageState();
}

class _RegisPageState extends State<RegisPage> {
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  // final TextEditingController confirmPass = TextEditingController();

  String? nameError;
  String? emailError;
  String? passwordError;
  String? confirmPassError;

  void clearErrors() {
    setState(() {
      nameError = null;
      emailError = null;
      passwordError = null;
      confirmPassError = null;
    });
  }

  void _clearForm() {
    name.clear();
    email.clear();
    password.clear();
  }

  void handleSubmit() async {
    clearErrors();

    if (!_formKey.currentState!.validate()) return;

    final nama = name.text;
    final mail = email.text;
    final pass = password.text;

    setState(() => _loading = true);
    
    try {
      await auth().register(nama, mail, pass);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data Berhasil Disimpan.'),
          duration: const Duration(seconds: 3),
        ),
      );
      _clearForm();
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan data. Silakan coba lagi.'),
          duration: const Duration(seconds: 3),
        ),
      );
    }finally {
      setState(() => _loading = false);
    }
  }
  bool isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Silakan Masukkan Nama Anda';
                            }
                            return null;
                          },
                          onChanged: (_) => clearErrors(),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 39, 55, 77),
                            ),
                            errorText: nameError,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Silakan Masukkan Email Anda';
                            }
                            return null;
                          },
                          onChanged: (_) => clearErrors(),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Gmail',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 39, 55, 77),
                            ),
                            errorText: emailError,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: password,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Silakan Masukkan Password Anda';
                            }
                            return null;
                          },
                          onChanged: (_) => clearErrors(),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          obscureText: !isPasswordVisible,
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
                        const SizedBox(height: 30),
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
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
                      padding: EdgeInsets.only(top: 2, bottom: 5, right: 5, left: 5),
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
