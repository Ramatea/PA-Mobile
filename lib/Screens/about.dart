// about_us_page.dart
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Us Page',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Nama: []',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'NIM: []',
              style: TextStyle(fontSize: 18),
            ),
            // Add other information as needed
          ],
        ),
      ),
    );
  }
}
