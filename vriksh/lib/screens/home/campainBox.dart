import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'campainDetails.dart';

class CampainBox extends StatelessWidget {
  const CampainBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CampainDetails()))
      },
      child: Container(
          margin: EdgeInsets.only(
            top: 20,
          ),
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 12, 59, 5),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.business_sharp,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "KPD org",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.location_on,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Allahabad India",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.date_range),
                      Text("12 Fab 2022"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.people),
                      Text("12"),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
