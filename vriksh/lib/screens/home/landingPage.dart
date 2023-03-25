import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vriksh/auth/welcome.dart';
import 'package:vriksh/screens/community/communityDrives.dart';
import 'package:vriksh/screens/home/homeApps.dart';
import 'package:vriksh/screens/map/SelectAddress.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 35,
            left: 2,
            right: 2,
          ),
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _selectedIndex = index);
            },
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                child: SelectLocation(),
              ),
              Container(
                child: HomeApps(),
              ),
              Container(
                child: CommunityDrives(),
              ),
              Container(
                color: Color.fromARGB(255, 194, 255, 184),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: false,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        }),
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.location_on),
            title: const Text('Map'),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.apps),
              title: const Text('Home'),
              activeColor: Colors.purpleAccent),
          BottomNavyBarItem(
            icon: const Icon(Icons.people_sharp),
            title: const Text('Community'),
            activeColor: Color.fromARGB(255, 50, 131, 37),
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.wallet),
              title: const Text('Wallet'),
              activeColor: Colors.pink),
        ],
      ),
    );
  }
}
