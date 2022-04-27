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
  var profile, category;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _socialController = TextEditingController();
  TextEditingController _specializationController = TextEditingController();

  TextEditingController _addressLine1Controller = TextEditingController();
  TextEditingController _addressLine2Controller = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _zipController = TextEditingController();

  bool isLoading = true;
  bool hasError = false;

  void initProfile() async {
    try {
      profile = (await getAuth("business/profile"))['business'];
      if (profile['name'] != null) {
        _nameController.text = profile['name'];
      }
      if (profile['phone'] != null) {
        _phoneController.text = profile['phone'];
      }
      if (profile['socialMediaLink'] != null) {
        _socialController.text = profile['socialMediaLink'];
      }
      if (profile['specialization'] != null) {
        _specializationController.text = profile['specialization'];
      }
      if (profile['category'] != null) {
        category = profile['category'];
      }
      _addressLine1Controller.text = profile['address']['line1'];
      _addressLine2Controller.text = profile['address']['line2'];
      _cityController.text = profile['address']['city'];
      _stateController.text = profile['address']['state'];
      _zipController.text = profile['address']['zip'];
    } catch (e) {
      print(e);
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
                                "assets/Organization.png",
                                height: 200,
                              ),
                            ),
                            isEditing
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, bottom: 17, right: 20),
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
                                      profile["name"] ?? "Please enter a name",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20, top: 20, bottom: 17),
                              child: Text("Category:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                            ),
                            isEditing
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20, bottom: 17),
                                    child: DropdownButton<String>(
                                      value: category,
                                      hint: Text("Select Category"),
                                      icon: const Icon(Icons.arrow_drop_down),
                                      elevation: 16,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      isExpanded: true,
                                      underline: Container(
                                        height: 2,
                                        color: Colors.black,
                                      ),
                                      onChanged: (String? newValue) {
                                         if (!mounted) return;
                                        setState(() {
                                          category = newValue;
                                        });
                                      },
                                      items: <String>[
                                        "Clothing",
                                        "Furniture",
                                        "Decor",
                                        "Cosmetics",
                                        "Food"
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, bottom: 17, top: 0),
                                    child: Text(
                                      profile["category"] ??
                                          "Please enter a category",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 17, top: 0),
                              child: Text("Address:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                            ),
                            isEditing
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, bottom: 17, right: 20),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          obscureText: false,
                                          controller: _addressLine1Controller,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
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
                                            obscureText: false,
                                            controller: _addressLine2Controller,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
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
                                            controller: _cityController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter this field';
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
                                            obscureText: false,
                                            controller: _stateController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter this field';
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
                                            obscureText: false,
                                            controller: _zipController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter this field';
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
                                          ', ' +
                                          profile['address']['line2'] +
                                          ', ' +
                                          profile['address']['city'] +
                                          ', ' +
                                          profile['address']['state'] +
                                          ' - ' +
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
                                      fontWeight: FontWeight.w700)),
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 17, right: 20),
                              child: Text("Social Media:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                            ),
                            isEditing
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, bottom: 17, right: 20),
                                    child: TextFormField(
                                      controller: _socialController,
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 17, right: 20),
                              child: Text("Specialization:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                            ),
                            isEditing
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, bottom: 17, right: 20),
                                    child: TextFormField(
                                      controller: _specializationController,
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
                                          labelText: "Specialization"),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, bottom: 17, right: 20),
                                    child: Text(
                                      profile['specialization'] ??
                                          "Please enter a specialization",
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
                                          print(_nameController.text);
                                          print(category);
                                          if (_formKey.currentState!
                                              .validate()) {
                                            var body = {
                                              "category": category,
                                              "name": _nameController.text,
                                              "phone": _phoneController.text,
                                              "socialMediaLink":
                                                  _socialController.text,
                                              "specialization":
                                                  _specializationController
                                                      .text,
                                              "address": {
                                                'line1': _addressLine1Controller
                                                    .text,
                                                'line2': _addressLine2Controller
                                                    .text,
                                                'city': _cityController.text,
                                                'state': _stateController.text,
                                                'zip': _zipController.text,
                                              }
                                            };
                                            try {
                                              showLoader();
                                              var resp = await patchAuth(
                                                  "business/update-profile",
                                                  jsonEncode(body));
                                              if (resp['message'] ==
                                                  "Business updated successfully") {
                                                closeLoader();
                                                setState(() {
                                                   if (!mounted) return;
                                                  isEditing = false;
                                                  profile['phone'] =
                                                      _phoneController.text;
                                                  profile['socialMediaLink'] =
                                                      _socialController.text;
                                                  profile['address']['line1'] =
                                                      _addressLine1Controller
                                                          .text;
                                                  profile['address']['line2'] =
                                                      _addressLine2Controller
                                                          .text;
                                                  profile['address']['city'] =
                                                      _cityController.text;
                                                  profile['address']['state'] =
                                                      _stateController.text;
                                                  profile['address']['zip'] =
                                                      _zipController.text;
                                                  profile['specialization'] =
                                                      _specializationController
                                                          .text;
                                                  profile['category'] =
                                                      category;
                                                  profile['name'] =
                                                      _nameController.text;
                                                });
                                                showSnackBar(
                                                    "Profile updated successfully");
                                              }
                                            } catch (e) {
                                              showSnackBar(e.toString());
                                            }
                                          }
                                        },
                                        child: Text("Save")),
                                  )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, bottom: 17, right: 20),
                              child: Row(children: [
                                Text(
                                  "Visibility Status:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    profile['visible'] == true
                                        ? "Public"
                                        : "Private",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
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
                                    if (profile['visible'] == false &&
                                        (profile['name'] == null ||
                                            profile['category'] == null ||
                                            profile['specialization'] == null ||
                                            profile['address']['line1'] ==
                                                null ||
                                            profile['address']['line2'] ==
                                                null ||
                                            profile['address']['city'] ==
                                                null ||
                                            profile['address']['state'] ==
                                                null ||
                                            profile['address']['zip'] == null ||
                                            profile['phone'] == null ||
                                            profile['socialMediaLink'] ==
                                                null)) {
                                      showSnackBar(
                                          "Please fill all the details before going public");
                                    } else {
                                      try {
                                        showLoader();
                                        var resp = await patchAuth(
                                            "business/set-visibility", null);
                                        showSnackBar(resp["message"]);
                                        setState(() {
                                          profile = resp["business"];
                                        });
                                        closeLoader();
                                      } catch (e) {
                                        closeLoader();
                                        showSnackBar(e.toString());
                                      }
                                    }
                                  },
                                  child: Text("Change Visibility Status")),
                            ),
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
