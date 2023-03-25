import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vriksh/screens/home/campainBox.dart';

class HomeApps extends StatefulWidget {
  const HomeApps({super.key});

  @override
  State<HomeApps> createState() => HomeAppsState();
}

class HomeAppsState extends State<HomeApps> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 194, 255, 184),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              children: [
                Text(
                  "Your Drives",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CampainBox(),
                CampainBox(),
                CampainBox(),
                CampainBox(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
