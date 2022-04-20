import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/loader.dart';
import 'package:lofy_frontend/Screens/category_businesses_screen.dart';
import 'package:lofy_frontend/Screens/home_page.dart';
import 'package:lofy_frontend/Screens/landing_screen.dart';
import 'package:lofy_frontend/Screens/login_signup_screen.dart';
import 'package:lofy_frontend/utils/navigator.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigatorService.navigatorKey,
      title: 'Flutter Demo',
      home: CategoryBusinessesScreen(
        category: "clothing",
      ),
    );
  }
}
