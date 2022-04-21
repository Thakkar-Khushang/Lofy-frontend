import 'package:flutter/material.dart';
import 'package:lofy_frontend/my_app.dart';
import 'package:lofy_frontend/utils/auth.utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final loggedIn = await isLoggedIn();
  final userType = await getUserType();
  runApp(MyApp(loggedIn: loggedIn, userType: userType));
}
