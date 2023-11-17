  import 'package:flutter/material.dart';

  class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 35,
              left: 340,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
            child: Container(
              width: double.infinity,
              height: 240,
              color: Color.fromRGBO(78, 201, 223, 0.1),
              child: Icon(
                Icons.notification_important_sharp,
                size: 30,
                color: Colors.white,
              ),
            ),
            ),
            ),
          ],
      )
      ),
    );
  }
}