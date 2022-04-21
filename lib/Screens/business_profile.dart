import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/business_navigation_bar.dart';

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({Key? key}) : super(key: key);

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
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
              child: ListView(children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 28.0, left: 35, right: 35),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            icon: Icon(Icons.edit, color: Colors.black))
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, bottom: 17, top: 20),
                  child: Text("Address:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ),
                isEditing
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
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: TextFormField(
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Address line 2',
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
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: TextFormField(
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'State',
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
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: TextFormField(
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Pincode',
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
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, bottom: 17, right: 20),
                        child: Text(
                          "just a generic apartment, just a generic address, just a generic city",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 17),
                  child: Text("Contact Details:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, bottom: 17, right: 20),
                  child: isEditing
                      ? TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
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
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "+919876543210",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, bottom: 17, right: 20),
                  child: isEditing
                      ? TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Email"),
                        )
                      : Row(children: [
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
                              "email@gmail.com",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, bottom: 17, right: 20),
                  child: Text("Social Media:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ),
                isEditing
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, bottom: 17, right: 20),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Social Media Link"),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, bottom: 17, right: 20),
                        child: Text(
                          "https://www.facebook.com/organizationXYZ",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
              ])),
        ));
  }
}
