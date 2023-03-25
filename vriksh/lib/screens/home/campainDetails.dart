import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CampainDetails extends StatefulWidget {
  const CampainDetails({super.key});

  @override
  State<CampainDetails> createState() => _CampainDetailsState();
}

class _CampainDetailsState extends State<CampainDetails> {
  int _loading = 0;

  void initState() {
    super.initState();
    setState(() {
      _loading = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Campaign Details',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        // back button
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _loading == 0
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(),
    );
  }
}
