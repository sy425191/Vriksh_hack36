import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewCampaign extends StatefulWidget {
  const NewCampaign({super.key});

  @override
  State<NewCampaign> createState() => _NewCampaignState();
}

class _NewCampaignState extends State<NewCampaign> {
  @override
  Widget build(BuildContext context) {
    Future<DateTime?> res;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Create Campaign',
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
      body: Container(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          // title -> text,
          // city -> text
          // datetime -> using datetime picker
          // notes -> large text box
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Title',
                  prefixIcon: Icon(Icons.title),
                ),
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  setState(() {
                    // _houseNo = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'City',
                  prefixIcon: Icon(Icons.location_city),
                ),
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  setState(() {
                    // _houseNo = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              // date time picker
              // first date = today, last date -> today + 3 months
              OutlinedButton(
                onPressed: () async {},
                child: Text("Select Date"),
              ),

              // notes
              TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Notes',
                  prefixIcon: Icon(Icons.notes),
                ),
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  setState(() {
                    // _houseNo = value;
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              // submit button
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Submit"),
                ),
              ),

              // line break
              Center(
                child: Container(
                  height: 25,
                  width: MediaQuery.of(context).size.width - 100,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
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
