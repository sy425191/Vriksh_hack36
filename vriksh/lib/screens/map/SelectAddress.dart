import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vriksh/apiServices.dart';
import 'package:vriksh/screens/map/newCampaign.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  late GoogleMapController mapController;
  int _showBottomSheet = 0;

  var aqi = 0;
  var pm2_5 = 0.0;
  var pm10 = 0.0;
  var co = 0.0;

  bool _loading = true;

  void initState() {
    super.initState();
    setState(() {
      _loading = false;
    });
  }

  var zone = "RED";

  final LatLng _center = const LatLng(25.491336, 81.863232);
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  LatLng _selectedLocation = const LatLng(25.491336, 81.863232);

  void onTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
    _markers = {};
    _markers.add(
      Marker(
        markerId: const MarkerId('1'),
        position: location,
        infoWindow: const InfoWindow(
          title: 'Selected Location',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  void onCameraMove(CameraPosition position) {
    if (_markers.isNotEmpty) {
      setState(() {
        _markers = {};
      });
    }
  }

  // void getUserLocation() async {
  //   var loc = await _determinePosition();
  //   print("Getting user Location");
  //   print(loc);
  // }

  void _analyse() async {
    setState(() {
      _loading = true;
    });
    // get the data from api
    if (_showBottomSheet == 0) {
      http.Response res = await ApiServices().analyseLatLong(_selectedLocation);
      var data = jsonDecode(res.body);

      setState(() {
        aqi = data['pollution']['list'][0]['main']['aqi'];
        pm2_5 = data['pollution']['list'][0]['components']['pm2_5'];
        pm10 = data['pollution']['list'][0]['components']['pm10'];
        co = data['pollution']['list'][0]['components']['co'];
        zone = data['region'];
      });

      setState(() {
        _showBottomSheet = 1;
      });
    } else {
      setState(() {
        _showBottomSheet = 0;
      });
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading == true
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Container(
                height: 45,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 3,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select Location',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // if marker is not selected
                    if (!_markers.isEmpty)
                      ElevatedButton(
                        onPressed: () {
                          _analyse();
                        },
                        child: _showBottomSheet == 0
                            ? Text("Analyse")
                            : Text("Close"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                      )
                    else
                      Container(),
                  ],
                ),
              ),
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 17.0,
                  ),
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: false,
                  onMapCreated: _onMapCreated,
                  mapType: MapType.hybrid,
                  // show places
                  compassEnabled: true,
                  onTap: onTap,
                  // onCameraMove: onCameraMove,
                  markers: _markers,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                ),
              ),
              _showBottomSheet == 0
                  ? Container()
                  : Container(
                      height: 220,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                child: zone == "RED"
                                    ? Container(
                                        width: 200,
                                        height: 100,
                                        margin: EdgeInsets.only(
                                          top: 20,
                                        ),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          color: Colors.red,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Red Zone",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      )
                                    : zone == "ORANGE"
                                        ? Container(
                                            width: 200,
                                            height: 100,
                                            margin: EdgeInsets.only(
                                              top: 20,
                                            ),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              color: Colors.orange,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Orange Zone",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: 200,
                                            height: 100,
                                            margin: EdgeInsets.only(
                                              top: 20,
                                            ),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              color: Colors.green,
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Green Zone",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(200, 50),
                                  backgroundColor:
                                      Color.fromARGB(225, 176, 220, 255),
                                  foregroundColor: Colors.black,
                                ),
                                onPressed: () => {
                                  // send to campaign page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewCampaign(),
                                    ),
                                  ),
                                },
                                child: Text("Start Campaign"),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () => {
                                  // send to tips page for improving the environment
                                },
                                child: Icon(Icons.info, color: Colors.black),
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "AQI:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    " ${aqi}", // get from api
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                width: 100,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "PM 2.5:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    " ${pm2_5}", // get from api
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                width: 100,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "PM 10:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    " ${pm10}", // get from api
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                width: 100,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "CO:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    " ${co}", // get from api
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
            ],
          );
  }
}

// Future<Position> _determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }
//   return await Geolocator.getCurrentPosition();
// }
