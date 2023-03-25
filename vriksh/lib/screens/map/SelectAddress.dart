import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  LatLng _selectedLocation = const LatLng(45.521563, -122.677433);

  void onTap(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text('Selected Location: $_selectedLocation'),
        ),
        Expanded(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
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
          ),
        )
      ],
    );
  }
}
