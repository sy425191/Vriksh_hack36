import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:vriksh/auth/class/user.dart';
import 'package:vriksh/auth/welcome.dart';
import 'package:vriksh/screens/home/homeApps.dart';
import 'package:vriksh/screens/home/landingPage.dart';
import 'package:vriksh/screens/utils/splashScreen.dart';

import 'localStorage.dart';

class homeAppState extends StatefulWidget {
  const homeAppState({super.key});

  @override
  State<homeAppState> createState() => _homeAppStateState();
}

class _homeAppStateState extends State<homeAppState> {
  var _loading = true;

  user? userState;

  void initState() {
    _loadUser();
  }

  void _loadUser() async {
    userState = await getuser();
    print(userState);
    setState(() {
      _loading = false;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hack36 Vriksha',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: const SplashScreen(),
        nextScreen:
            (userState == null) ? const WelcomeScreen() : const LandingPage(),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
