import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String username;

  // Konstruktor untuk menerima nama pengguna sebagai parameter
  ProfileScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          // Tombol untuk keluar dari profil
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Logika logout atau pindah ke halaman login
              Navigator.pop(context); // Kembali ke halaman sebelumnya
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menampilkan informasi profil
            Icon(
              Icons.account_circle,
              size: 100,
              color: Color.fromRGBO(99, 161, 208, 100),
            ),
            SizedBox(height: 20),
            Text(
              'Welcome, $username!', // Menampilkan nama pengguna
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
