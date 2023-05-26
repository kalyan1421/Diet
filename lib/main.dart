import 'package:diettest2/splashscreens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
Future main() async {

  ErrorWidget.builder = (FlutterErrorDetails details){
    return Text(
      "Error Please Restart App",
          // "${details.exception}",
      style: GoogleFonts.abrilFatface(
        color: Colors.pink[200],
        fontSize: 15.0,
      ),
      textAlign: TextAlign.center,
    );
  };
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Diet",
      theme: ThemeData(
        primaryColor:  Colors.white10
      ),
      home: const SplashScreen(),
    );
  }
}

