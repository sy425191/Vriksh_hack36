import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 194, 255, 184),
      child: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Container(
            height: 60,
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              bottom: 10,
            ),
            child: Container(
              // get started button with rounded corners and google logo on it for oauth2
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: const Center(
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
