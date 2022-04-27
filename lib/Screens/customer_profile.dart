import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/customer_navigation_bar.dart';
import 'package:lofy_frontend/Components/error_page.dart';
import 'package:lofy_frontend/Components/loader.dart';
import 'package:lofy_frontend/Screens/customer_orders.dart';
import 'package:lofy_frontend/utils/auth.utils.dart';
import 'package:lofy_frontend/utils/http.utils.dart';
import 'package:lofy_frontend/utils/snackbar.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({Key? key}) : super(key: key);

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  bool isEditing = false;
  bool isLoading = true;
  bool hasError = false;
  var profile;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController addressline1Controller = TextEditingController();
  TextEditingController addressline2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  void initProfile() async {
    try {
      profile = (await getAuth("customer/profile"))['customer'];
      if (profile['name'] != null) {
        _nameController.text = profile['name'];
      }
      if (profile['phone'] != null) {
        _phoneController.text = profile['phone'];
      }
      addressline1Controller.text = profile['address']['line1'];
      addressline2Controller.text = profile['address']['line2'];
      cityController.text = profile['address']['city'];
      stateController.text = profile['address']['state'];
      pincodeController.text = profile['address']['zip'];
    } catch (e) {
      if (!mounted) return;
      setState(() {
        hasError = true;
      });
    }
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initProfile();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Hi User!"),
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: isLoading || hasError
            ? null
            : FloatingActionButton.extended(
                backgroundColor: Colors.black,
                label: Text('My Orders'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerOrdersScreen(),
                    ),
                  );
                },
              ),
        bottomNavigationBar: CustomerNavBar(
          index: 2,
        ),
        body: Center(
          child: SizedBox(
              width: screenSize.width,
              child: isLoading
                  ? PageLoader()
                  : hasError
                      ? ErrorComponent()
                      : Form(
                          key: _formKey,
                          child: ListView(children: [
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
                                          if (!mounted) return;
                                          setState(() {
                                            isEditing = !isEditing;
                                          });
                                        },
                                        icon: Icon(Icons.edit,
                                            color: Colors.black))
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Image.asset(
                                "assets/person.png",
                                height: 200,
                              ),
                            ),
                            isEditing
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: TextFormField(
                                      controller: _nameController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter this field';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelText: "Name"),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      profile['name'] ?? "Please enter a name",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 17, top: 20),
                              child: Text("Address:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                            ),
                            isEditing
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, bottom: 17, right: 20),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: addressline1Controller,
                                          obscureText: false,
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please enter this field';
                                            }
                                            return null;
                                          },
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
                                            controller: addressline2Controller,
                                            obscureText: false,
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please enter this field';
                                              }
                                              return null;
                                            },
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
                                            controller: cityController,
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please enter a city';
                                              }
                                              return null;
                                            },
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
                                            controller: stateController,
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please enter a state';
                                              }
                                              return null;
                                            },
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
                                            controller: pincodeController,
                                            obscureText: false,
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please enter a pincode';
                                              }
                                              return null;
                                            },
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
                                      profile['address']['line1'] +
                                          ", " +
                                          profile['address']['line2'] +
                                          ", " +
                                          profile['address']['city'] +
                                          ", " +
                                          profile['address']['state'] +
                                          " - " +
                                          profile['address']['zip'],
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 17, right: 20),
                              child: isEditing
                                  ? TextFormField(
                                      controller: _phoneController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter this field';
                                        }
                                        return null;
                                      },
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            var body = {
                                              "name": _nameController.text,
                                              "phone": _phoneController.text,
                                              "address": {
                                                "line1":
                                                    addressline1Controller.text,
                                                "line2":
                                                    addressline2Controller.text,
                                                "city": cityController.text,
                                                "state": stateController.text,
                                                "zip": pincodeController.text,
                                              }
                                            };
                                            try {
                                              showLoader();
                                              var resp = await patchAuth(
                                                  "customer/update-profile",
                                                  jsonEncode(body));
                                              if (resp['message'] ==
                                                  "Customer updated successfully") {
                                                if (!mounted) return;
                                                setState(() {
                                                  isEditing = false;
                                                  profile['name'] =
                                                      _nameController.text;
                                                  profile['phone'] =
                                                      _phoneController.text;
                                                });
                                                closeLoader();
                                                showSnackBar(
                                                    "Profile updated successfully");
                                              }
                                            } catch (e) {
                                              showSnackBar(e.toString());
                                              closeLoader();
                                            }
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
                          ]),
                        )),
        ));
  }
}
