import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:vriksh/auth/welcome.dart';
import 'package:vriksh/screens/home/homeApps.dart';
import 'package:vriksh/screens/home/landingPage.dart';
import 'package:vriksh/screens/utils/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: SplashScreen(),
        nextScreen: LandingPage(),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
