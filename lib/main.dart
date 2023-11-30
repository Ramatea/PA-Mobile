import 'package:flutter/material.dart';
import 'package:managment/Screens/introduction_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Comment or remove the Firebase initialization line for now
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroductionPage(),
    );
  }
}
