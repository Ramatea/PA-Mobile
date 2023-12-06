import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:managment/Screens/introduction_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:managment/data/model/manage.dart';
import 'package:managment/firebase_options.dart';
import 'package:managment/provider/theme_provider.dart';
import 'package:managment/widgets/bottomnavigationbar.dart';
import 'package:provider/provider.dart';



void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, 
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => ThemeProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => DataManage()),
      ],
      child: MaterialApp( 
        debugShowCheckedModeBanner: false, 
        home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if (snapshot.hasData){
            return Bottom();
          }else{
            return IntroductionPage();
          }
        },
      ),
      ),
    );
  }
}

