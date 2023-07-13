import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vriksh/auth/class/user.dart';

class ApiServices {
  static const String BASE_URL = "http://192.168.43.106:5000";

  Future<dynamic> analyseLatLong(LatLng _latlong) async {
    var responseJson;
    try {
      var url = Uri.parse(
          '${BASE_URL}/analyseLatLong/${_latlong.latitude}/${_latlong.longitude}');
      var response = await http.get(url);
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> tryLogin(loginUser user) async {
    var resposejson;
    try {
      var url = Uri.parse('${BASE_URL}/api/login/');
      var response = await http.post(
        url,
        body: jsonEncode(<String, String>{
          'email': user.email,
          'password': user.password,
        }),
      );

      return response;
    } catch (e) {
      print(e);
    }
  }
}
