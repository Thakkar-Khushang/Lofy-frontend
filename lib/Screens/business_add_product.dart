import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/business_navigation_bar.dart';

class BusinessAddProductScreen extends StatefulWidget {
  BusinessAddProductScreen({Key? key}) : super(key: key);

  @override
  State<BusinessAddProductScreen> createState() =>
      _BusinessAddProductScreenState();
}

class _BusinessAddProductScreenState extends State<BusinessAddProductScreen> {
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
            onPressed: () {},
            label: Text("Add Product")),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BusinessNavBar(index: 1),
        body: Center(
          child: SizedBox(
              width: screenSize.width,
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
                  child: Text("Description:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, bottom: 17, right: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
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
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, bottom: 17, right: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Price',
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
                )
              ])),
        ));
  }
}
