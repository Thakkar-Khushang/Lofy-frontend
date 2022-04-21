import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/loader.dart';
import 'package:lofy_frontend/Screens/business_profile.dart';
import 'package:lofy_frontend/Screens/home_page.dart';
import 'package:lofy_frontend/utils/http.utils.dart';
import 'package:lofy_frontend/utils/navigator.dart';
import 'package:lofy_frontend/utils/snackbar.dart';

class AddressInputScreen extends StatefulWidget {
  AddressInputScreen({Key? key, required this.userType}) : super(key: key);
  final userType;

  @override
  State<AddressInputScreen> createState() => _AddressInputScreenState();
}

class _AddressInputScreenState extends State<AddressInputScreen> {
  var _formKey = GlobalKey<FormState>();

  TextEditingController _addressline1Controller = TextEditingController();
  TextEditingController _addressline2Controller = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Tell us your location',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 50, right: 50),
                child: TextFormField(
                  obscureText: false,
                  controller: _addressline1Controller,
                  decoration: InputDecoration(
                    labelText: 'Address line 1',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    labelStyle: TextStyle(fontSize: 18, color: Colors.black),
                    fillColor: Color.fromARGB(255, 250, 250, 250),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 50, right: 50),
                child: TextFormField(
                  obscureText: false,
                  controller: _addressline2Controller,
                  decoration: InputDecoration(
                    labelText: 'Address line 2',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    labelStyle: TextStyle(fontSize: 18, color: Colors.black),
                    fillColor: Color.fromARGB(255, 250, 250, 250),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 50, right: 50),
                child: TextFormField(
                  obscureText: false,
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'City',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    labelStyle: TextStyle(fontSize: 18, color: Colors.black),
                    fillColor: Color.fromARGB(255, 250, 250, 250),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 50, right: 50),
                child: TextFormField(
                  obscureText: false,
                  controller: _stateController,
                  decoration: InputDecoration(
                    labelText: 'State',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    labelStyle: TextStyle(fontSize: 18, color: Colors.black),
                    fillColor: Color.fromARGB(255, 250, 250, 250),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 50, right: 50),
                child: TextFormField(
                  obscureText: false,
                  controller: _pincodeController,
                  decoration: InputDecoration(
                    labelText: 'Pincode',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    labelStyle: TextStyle(fontSize: 18, color: Colors.black),
                    fillColor: Color.fromARGB(255, 250, 250, 250),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 50, right: 50),
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
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
                            "${widget.userType == "Buyer" ? "customer" : "business"}/update-profile",
                            jsonEncode(body));
                        showSnackBar(resp['message']);
                        closeLoader();
                        if (resp['message'] ==
                            '${widget.userType == "Buyer" ? "Customer" : "Business"} updated successfully') {
                          pushReplaceWithoutAnimation(widget.userType == "Buyer"
                              ? MyHomePage()
                              : BusinessProfileScreen());
                        }
                      } catch (e) {
                        closeLoader();
                        showSnackBar(e.toString());
                      }
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
