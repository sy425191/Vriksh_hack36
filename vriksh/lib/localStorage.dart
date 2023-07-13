import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vriksh/auth/class/user.dart';

void saveuser(user user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("user") == true) {
    prefs.remove("user");
  }

  var json = user.toJson();
  prefs.setString("user", jsonEncode(json));
}

Future<user?> getuser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("user") == false) {
    return null;
  }
  var userstorage = prefs.getString("user");
  // return jsonDecode(userstorage!);
  return user.fromJson(jsonDecode(userstorage!));
}
