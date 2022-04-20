import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lofy_frontend/utils/navigator.dart';

bool isOpen = false;

showLoader() {
  isOpen = true;
  showDialog(
      useRootNavigator: false,
      barrierDismissible: false,
      context: NavigatorService.navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return Loader();
      });
}

closeLoader() {
  if (isOpen) {
    isOpen = false;
    Navigator.of(NavigatorService.navigatorKey.currentContext!).pop();
  }
}

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  final spinkit =
      SpinKitPouringHourGlass(color: Colors.black, strokeWidth: 2, size: 70);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Center(
            // alignment: FractionalOffset.center,
            // height: 80.0,
            // padding: const EdgeInsets.all(20.0),
            child: spinkit),
      ),
    );
  }
}

class PageLoader extends StatefulWidget {
  const PageLoader({Key? key}) : super(key: key);

  @override
  _PageLoaderState createState() => _PageLoaderState();
}

class _PageLoaderState extends State<PageLoader> {
  final spinkit = SpinKitChasingDots(color: Colors.black, size: 70);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Container(color: Colors.white, child: Center(child: spinkit)));
  }
}
