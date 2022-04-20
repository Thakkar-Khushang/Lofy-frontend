import 'package:flutter/material.dart';
import 'package:lofy_frontend/utils/navigator.dart';

void showSnackBar(String message, {int duration = 3}) {
  ScaffoldMessenger.of(NavigatorService.navigatorKey.currentContext!)
      .showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(seconds: duration),
  ));
}
