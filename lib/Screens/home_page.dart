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
  var _formKey = GlobalKey<FormState>();

  TextEditingController _addressline1Controller = TextEditingController();
  TextEditingController _addressline2Controller = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();

  return showModalBottomSheet(
      isScrollControlled: true,
      context: NavigatorService.navigatorKey.currentContext!,
      isDismissible: false,
      builder: (context) => Wrap(children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Tell us your location',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 50, right: 50),
                            child: TextFormField(
                              obscureText: false,
                              controller: _addressline1Controller,
                              decoration: InputDecoration(
                                labelText: 'Address line 1',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                labelStyle: TextStyle(
                                    fontSize: 18, color: Colors.black),
                                fillColor: Color.fromARGB(255, 250, 250, 250),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2.0),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 50, right: 50),
                          child: TextFormField(
                            obscureText: false,
                            controller: _addressline2Controller,
                            decoration: InputDecoration(
                              labelText: 'Address line 2',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              labelStyle:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              fillColor: Color.fromARGB(255, 250, 250, 250),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 50, right: 50),
                          child: TextFormField(
                            obscureText: false,
                            controller: _cityController,
                            decoration: InputDecoration(
                              labelText: 'City',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              labelStyle:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              fillColor: Color.fromARGB(255, 250, 250, 250),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 50, right: 50),
                          child: TextFormField(
                            obscureText: false,
                            controller: _stateController,
                            decoration: InputDecoration(
                              labelText: 'State',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              labelStyle:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              fillColor: Color.fromARGB(255, 250, 250, 250),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 50, right: 50),
                          child: TextFormField(
                            obscureText: false,
                            controller: _pincodeController,
                            decoration: InputDecoration(
                              labelText: 'Pincode',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              labelStyle:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              fillColor: Color.fromARGB(255, 250, 250, 250),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 50, right: 50),
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                              onPressed: () async {
                                String address = _addressline1Controller.text +
                                    ', ' +
                                    _addressline2Controller.text +
                                    ', ' +
                                    _cityController.text +
                                    ', ' +
                                    _stateController.text +
                                    ' - ' +
                                    _pincodeController.text;
                                var body = {
                                  'address': address,
                                  'city': _cityController.text,
                                };
                                try {
                                  showLoader();
                                  var resp = await patchAuth(
                                      "customer/update-profile",
                                      jsonEncode(body));
                                  showSnackBar(resp['message']);
                                  closeLoader();
                                  Navigator.pop(context);
                                } catch (e) {
                                  closeLoader();
                                  showSnackBar(e.toString());
                                }
                              },
                              child: Text("Submit"),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]));
}
