import 'package:flutter/material.dart';
import 'package:managment/Screens/introduction_page.dart';
import 'package:managment/provider/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Comment or remove the Firebase initialization line for now
  // await Firebase.initializeApp();
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    );
}




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      darkTheme: ThemeData.dark(),
      themeMode: Provider.of<ThemeProvider>(context).themeMode == ThemeModeType.system
          ? ThemeMode.system
          : Provider.of<ThemeProvider>(context).themeMode == ThemeModeType.dark
              ? ThemeMode.dark
              : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: IntroductionPage(),
    );
  }
}
