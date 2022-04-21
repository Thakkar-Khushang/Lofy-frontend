import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lofy_frontend/Components/loader.dart';
import 'package:lofy_frontend/Screens/landing_screen.dart';
import 'package:lofy_frontend/utils/navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';

final _storage = FlutterSecureStorage();
Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

// Used to get the token
Future<dynamic> getToken() async {
  final token = await _storage.read(key: "token");

  if (token == null) {
    return null;
  }

  return token;
}

// Used for logging in
Future<void> writeToken(String token) async {
  await _storage.write(key: "token", value: token);
}

Future<void> writeUserType(String type) async {
  await _storage.write(key: "userType", value: type);
}

Future<void> clearStorageExceptToken() async {
  final token = await _storage.read(key: "token");
  await _storage.deleteAll();
  await _storage.write(key: "token", value: token);
}

// Used to logout
Future<void> deleteToken() async {
  SharedPreferences prefs = await _prefs;
  await _storage.deleteAll();
  await prefs.clear();
}

// Used to check if loggedIn
Future<bool> isLoggedIn() async {
  final token = await getToken();
  bool logInStatus = false;

  logInStatus = (token == null) ? false : true;

  return Future<bool>.value(logInStatus);
}

Future<String?> getUserType() async {
  final userType = await _storage.read(key: "userType");

  return userType;
}

Future<void> logOut({String? screenName, bool unauthorized = false}) async {
  showLoader();
  await deleteToken();
  await Navigator.push(
      NavigatorService.navigatorKey.currentContext!,
      MaterialPageRoute(
          builder: (newContext) => LandingPage(),
          settings: RouteSettings(name: '/')));
}
