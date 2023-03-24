import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeApps extends StatefulWidget {
  const HomeApps({super.key});

  @override
  State<HomeApps> createState() => HomeAppsState();
}

class HomeAppsState extends State<HomeApps> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Hi"),
      ),
    );
  }
}
