import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:vriksh/apiServices.dart';
import 'package:vriksh/auth/class/user.dart';
import 'package:vriksh/localStorage.dart';
import 'package:vriksh/screens/home/homeApps.dart';
import 'package:vriksh/screens/home/landingPage.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var _loading = true;

  @override
  void initState() {
    _loadUser();
  }

  void _loadUser() async {
    var user = getuser();
    setState(() {
      _loading = false;
    });
  }

  void loginHandler(BuildContext context) async {
    var emailText = emailController.text;
    var passwordText = passwordController.text;

    var loginuser = loginUser(emailText, passwordText);

    setState(() {
      _loading = true;
    });

    try {
      var response = await ApiServices().tryLogin(loginuser);
      var data = jsonDecode(response.body);
      if (data['status'] == "success") {
        var newuser = user(data['data']['email'], data['data']['fname'],
            data['data']['lname'], data['data']['token']);
        saveuser(newuser);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LandingPage(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Incorrect Password'),
              content: Text('Please enter the correct password.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                color: Color.fromARGB(255, 65, 65, 65),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 1.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage('assets/welcome_charge_logo.png'),
                            height: 180,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Tree for',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 156, 156, 156),
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                'Sustainable',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Future',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 156, 156, 156),
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 250,
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 10,
                      ),
                      child: Container(
                        // get started button with rounded corners and google logo on it for oauth2
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            // email, and password
                            TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 66, 155, 85),
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 66, 155, 85),
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // login button
                            GestureDetector(
                              onTap: () => {
                                loginHandler(context),
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 76, 145, 11),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 240, 240, 240),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
