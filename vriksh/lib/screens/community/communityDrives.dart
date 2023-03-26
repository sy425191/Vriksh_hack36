import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../home/campainBox.dart';

class CommunityDrives extends StatefulWidget {
  const CommunityDrives({super.key});

  @override
  State<CommunityDrives> createState() => _CommunityDrivesState();
}

class _CommunityDrivesState extends State<CommunityDrives> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Column(
        children: const [
          SizedBox(
            height: 10,
          ),
          Text("Recent Published Drives"),
          SizedBox(
            height: 10,
          ),
          CampainBox(),
          CampainBox(),
          CampainBox(),
          CampainBox(),
        ],
      ),
    );
  }
}
