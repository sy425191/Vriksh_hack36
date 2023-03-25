import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CampainDetails extends StatefulWidget {
  const CampainDetails({super.key});

  @override
  State<CampainDetails> createState() => _CampainDetailsState();
}

class _CampainDetailsState extends State<CampainDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          color: Colors.green,
        ));
  }
}
