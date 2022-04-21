import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/business_navigation_bar.dart';
import 'package:lofy_frontend/Components/error_page.dart';
import 'package:lofy_frontend/Components/loader.dart';
import 'package:lofy_frontend/utils/auth.utils.dart';
import 'package:lofy_frontend/utils/http.utils.dart';
import 'package:lofy_frontend/utils/snackbar.dart';

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({Key? key}) : super(key: key);

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  var profile;

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _socialController = TextEditingController();

  bool isLoading = true;
  bool hasError = false;

  void initProfile() async {
    try {
      profile = (await getAuth("business/profile"))['business'];
      if (profile['phone'] != null) {
        _phoneController.text = profile['phone'];
      }
      if (profile['socialMediaLink'] != null) {
        _socialController.text = profile['socialMediaLink'];
      }
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
    initProfile();
  }

  bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Hi User!"),
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: BusinessNavBar(index: 2),
        body: Center(
          child: SizedBox(
              width: screenSize.width,
              child: isLoading
                  ? PageLoader()
                  : hasError
                      ? ErrorComponent()
                      : ListView(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 28.0, left: 35, right: 35),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "My Profile:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isEditing = !isEditing;
                                        });
                                      },
                                      icon:
                                          Icon(Icons.edit, color: Colors.black))
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Image.asset(
                              "assets/Organization.png",
                              height: 200,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Organization Name",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, bottom: 17, top: 20),
                            child: Text("Address:",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                          ),
                          isEditing && false
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 17, right: 20),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Address line 1',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          ),
                                          labelStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                          fillColor: Color.fromARGB(
                                              255, 250, 250, 250),
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: TextFormField(
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Address line 2',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            labelStyle: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                            fillColor: Color.fromARGB(
                                                255, 250, 250, 250),
                                            filled: true,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10.0,
                                        ),
                                        child: TextFormField(
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'City',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            labelStyle: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                            fillColor: Color.fromARGB(
                                                255, 250, 250, 250),
                                            filled: true,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: TextFormField(
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'State',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            labelStyle: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                            fillColor: Color.fromARGB(
                                                255, 250, 250, 250),
                                            filled: true,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: TextFormField(
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Pincode',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            labelStyle: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                            fillColor: Color.fromARGB(
                                                255, 250, 250, 250),
                                            filled: true,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 17, right: 20),
                                  child: Text(
                                    profile['address'] ??
                                        "Please enter an address",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 17),
                            child: Text("Contact Details:",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, bottom: 17, right: 20),
                            child: isEditing
                                ? TextField(
                                    controller: _phoneController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelText: "Phone Number"),
                                  )
                                : Row(children: [
                                    Text(
                                      "Number:",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        profile['phone'] ??
                                            "Please enter a phone number",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, bottom: 17, right: 20),
                            child: Row(children: [
                              Text(
                                "Email:",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  profile['email'],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, bottom: 17, right: 20),
                            child: Text("Social Media:",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                          ),
                          isEditing
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 17, right: 20),
                                  child: TextField(
                                    controller: _socialController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelText: "Social Media Link"),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 17, right: 20),
                                  child: Text(
                                    profile['socialMediaLink'] ??
                                        "Please enter a social media link",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                          isEditing
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                      ),
                                      onPressed: () async {
                                        var body = {};
                                        if (_socialController.text.trim() !=
                                            "") {
                                          body['socialMediaLink'] =
                                              _socialController.text;
                                        }
                                        if (_phoneController.text.trim() !=
                                            "") {
                                          body['phone'] = _phoneController.text;
                                        }
                                        try {
                                          showLoader();
                                          var resp = await patchAuth(
                                              "business/update-profile",
                                              jsonEncode(body));
                                          if (resp['message'] ==
                                              "Business updated successfully") {
                                            closeLoader();
                                            setState(() {
                                              isEditing = false;
                                              profile['phone'] =
                                                  _phoneController.text;
                                            });
                                            showSnackBar(
                                                "Profile updated successfully");
                                          }
                                        } catch (e) {
                                          showSnackBar(e.toString());
                                        }
                                      },
                                      child: Text("Save")),
                                )
                              : Container(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                                onPressed: () async {
                                  await logOut();
                                },
                                child: Text("Log Out")),
                          )
                        ])),
        ));
  }
}
