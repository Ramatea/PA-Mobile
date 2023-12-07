import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:managment/widgets/loginpage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroductionPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class IntroductionPage extends StatefulWidget {
  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  bool showBottomPart = true;

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      showNextButton: true,
      showSkipButton: true,
      skip: const Text("Skip", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromARGB(255, 36, 52, 73),)),
      onSkip: (){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      next: Icon(
        Icons.arrow_forward_ios,
        size: 15,
        color: Color.fromARGB(255, 34, 48, 68),
      ),
      done: const Text("Get Started", style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromARGB(255, 36, 52, 73),)),
      onDone: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      // Daftar halaman yang akan ditampilkan dalam halaman introduction
      pages: [
        PageViewModel(
          title: "Welcome to a new era of personal finance!",
          body: " WalletWhiz helps you make smart decisions for a healthier financial life",
          image: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Image.asset("images/logo.png", height: 300, width: 300),
            ),
          ),
          decoration: PageDecoration(
            titleTextStyle: GoogleFonts.daiBannaSil(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            bodyTextStyle: GoogleFonts.lato(
              fontSize: 16,
            ),
          ),
        ),
        PageViewModel(
          title: "Get Started",
          body: "Get started quickly and easily.",
          image: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
              child: Image.asset("images/Transfer.png", height: 300, width: 300),
            ),
          ),
          decoration: PageDecoration(
            titleTextStyle: GoogleFonts.daiBannaSil(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            bodyTextStyle: GoogleFonts.lato(
              fontSize: 18,
            ),
          ),
        ),
        PageViewModel(
          title: "Explore and Enjoy",
          body: "Explore the app and enjoy your journey.",
          image: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
              child: Image.asset("images/1.png", height: 300, width: 300),
            ),
          ),
          decoration: PageDecoration(
            titleTextStyle: GoogleFonts.daiBannaSil(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            bodyTextStyle: GoogleFonts.lato(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
