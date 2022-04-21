import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/loader.dart';
import 'package:lofy_frontend/Screens/business_add_product.dart';
import 'package:lofy_frontend/Screens/business_orders.dart';
import 'package:lofy_frontend/Screens/business_products.dart';
import 'package:lofy_frontend/Screens/business_profile.dart';
import 'package:lofy_frontend/Screens/business_screen.dart';
import 'package:lofy_frontend/Screens/category_businesses_screen.dart';
import 'package:lofy_frontend/Screens/customer_orders.dart';
import 'package:lofy_frontend/Screens/customer_profile.dart';
import 'package:lofy_frontend/Screens/home_page.dart';
import 'package:lofy_frontend/Screens/landing_screen.dart';
import 'package:lofy_frontend/Screens/login_signup_screen.dart';
import 'package:lofy_frontend/Screens/my_cart.dart';
import 'package:lofy_frontend/Screens/product_screen.dart';
import 'package:lofy_frontend/utils/auth.utils.dart';
import 'package:lofy_frontend/utils/navigator.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.loggedIn, this.userType}) : super(key: key);

  final loggedIn;
  final userType;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigatorService.navigatorKey,
      title: 'Flutter Demo',
      home: loggedIn
          ? userType == "Buyer"
              ? MyHomePage()
              : userType == "Seller"
                  ? BusinessProfileScreen()
                  : LandingPage()
          : LandingPage(),
    );
  }
}
