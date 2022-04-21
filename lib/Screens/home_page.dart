import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/category_card.dart';
import 'package:lofy_frontend/Components/customer_navigation_bar.dart';
import 'package:lofy_frontend/Components/error_page.dart';
import 'package:lofy_frontend/Components/loader.dart';
import 'package:lofy_frontend/Components/most_browsed_card.dart';
import 'package:lofy_frontend/Screens/business_screen.dart';
import 'package:lofy_frontend/Screens/category_businesses_screen.dart';
import 'package:lofy_frontend/utils/error.utils.dart';
import 'package:lofy_frontend/utils/http.utils.dart';
import 'package:lofy_frontend/utils/navigator.dart';
import 'package:lofy_frontend/utils/snackbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.isSigningup = false}) : super(key: key);
  final bool isSigningup;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var topBusinesses = [];
  List<Widget> topBusinessWidgets = [];
  var categories = [];
  List<Widget> categoryWidgets = [];
  bool isLoading = true;
  bool hasError = false;
  bool notFound = false;

  void initializeHomePage() async {
    if (widget.isSigningup) {
      await locationAskerModal();
    }
    try {
      var resp = await getAuth("customer/see-businesses/");
      topBusinesses = resp['topBusinesses'];
      categories = resp['categories'];
      for (int i = 0; i < topBusinesses.length; i++) {
        topBusinessWidgets.add(GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BusinessScreen(
                business: topBusinesses[i],
              );
            }));
          },
          child: MostBrowsedCard(
            business: topBusinesses[i],
          ),
        ));
      }
      for (int i = 0; i < categories.length; i++) {
        categoryWidgets.add(GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CategoryBusinessesScreen(
                  businesses: categories[i]['businesses'],
                  category: categories[i]['category'],
                ),
              ),
            );
          },
          child: CategoryCard(
            category: categories[i]['category'],
          ),
        ));
      }
    } on NotFoundException {
      setState(() {
        notFound = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        hasError = true;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeHomePage();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Hi User!"),
        ),
        bottomNavigationBar: CustomerNavBar(
          index: 0,
        ),
        body: SizedBox(
            width: screenSize.width,
            child: isLoading
                ? PageLoader()
                : hasError
                    ? ErrorComponent()
                    : notFound
                        ? ErrorComponent(
                            message: "No businesses found",
                          )
                        : ListView(
                            children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 18.0, bottom: 8.0, left: 10.0),
                                    child: Text("Most Browsed:",
                                        style: TextStyle(fontSize: 20)),
                                  ),
                                  SizedBox(
                                    height: 300,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: topBusinessWidgets,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 18.0, bottom: 8.0, left: 10.0),
                                    child: Text("Categories:",
                                        style: TextStyle(fontSize: 20)),
                                  ),
                                ] +
                                categoryWidgets)));
  }
}

locationAskerModal() {
  

  return showModalBottomSheet(
      isScrollControlled: true,
      context: NavigatorService.navigatorKey.currentContext!,
      isDismissible: false,
      builder: (context) => Wrap(children: [
            
          ]));
}
