import 'package:flutter/material.dart';

class NavigatorService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

Future<dynamic> pushReplaceWithoutAnimation(Widget page) {
  return Navigator.pushReplacement(
    NavigatorService.navigatorKey.currentContext!,
    PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  );
}

Future<dynamic> pushNamed<T extends Object>(String route) {
  return Navigator.pushNamed(
    NavigatorService.navigatorKey.currentContext!,
    route,
  );
}
