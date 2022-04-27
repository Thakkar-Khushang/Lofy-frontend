import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lofy_frontend/Components/business_navigation_bar.dart';
import 'package:lofy_frontend/Components/loader.dart';
import 'package:lofy_frontend/Screens/business_products.dart';
import 'package:lofy_frontend/utils/http.utils.dart';
import 'package:lofy_frontend/utils/navigator.dart';
import 'package:lofy_frontend/utils/snackbar.dart';

class BusinessAddProductScreen extends StatefulWidget {
  BusinessAddProductScreen({Key? key}) : super(key: key);

  @override
  State<BusinessAddProductScreen> createState() =>
      _BusinessAddProductScreenState();
}

class _BusinessAddProductScreenState extends State<BusinessAddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("My Products:"),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.black,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  showLoader();
                  var body = {
                    "name": _nameController.text,
                    "description": _descriptionController.text,
                    "price": _priceController.text,
                  };
                  var resp = await postAuth("product/add", jsonEncode(body));
                  showSnackBar(resp['message']);
                  closeLoader();
                  await pushReplaceWithoutAnimation(BusinessProductsScreen());
                } catch (e) {
                  print(e);
                  showSnackBar(e.toString());
                  closeLoader();
                }
              }
            },
            label: Text("Add Product")),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BusinessNavBar(index: 1),
        body: Center(
          child: SizedBox(
              width: screenSize.width,
              child: Form(
                key: _formKey,
                child: ListView(children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 28.0, left: 35, right: 35),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Add Product:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.asset(
                      "assets/Organization.png",
                      height: 200,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, bottom: 17, top: 20),
                    child: Text("Name:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                  Padding(
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
                          labelText: 'Name',
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
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 17),
                    child: Text("Description:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, bottom: 17, right: 20),
                      child: TextFormField(
                        controller: _descriptionController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter this field';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Description',
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
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 17),
                    child: Text("Price:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, bottom: 17, right: 20),
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,2}'))
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter this field';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Price',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        labelStyle:
                            TextStyle(fontSize: 18, color: Colors.black),
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
                  )
                ]),
              )),
        ));
  }
}
