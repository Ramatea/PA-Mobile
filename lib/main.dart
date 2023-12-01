import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:managment/Screens/introduction_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:managment/data/model/add_date.dart';
import 'package:managment/firebase_options.dart';
import 'package:managment/provider/theme_provider.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AdddataAdapter());
  await Hive.openBox<Add_data>('data');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
