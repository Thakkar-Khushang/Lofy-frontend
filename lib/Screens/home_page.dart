import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/category_card.dart';
import 'package:lofy_frontend/Components/most_browsed_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Hi User!"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: "My Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
          currentIndex: 0,
          onTap: (int index) {
            showModalBottomSheet(
                clipBehavior: Clip.hardEdge,
                context: context,
                builder: (context) => Container(
                      height: MediaQuery.of(context).size.height * 0.65,
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 50, right: 50),
                                  child: TextFormField(
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Address line 1',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      labelStyle: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                      fillColor:
                                          Color.fromARGB(255, 250, 250, 250),
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
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
                                    decoration: InputDecoration(
                                      labelText: 'Address line 2',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      labelStyle: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                      fillColor:
                                          Color.fromARGB(255, 250, 250, 250),
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
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
                                    decoration: InputDecoration(
                                      labelText: 'City',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      labelStyle: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                      fillColor:
                                          Color.fromARGB(255, 250, 250, 250),
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
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
                                    decoration: InputDecoration(
                                      labelText: 'State',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      labelStyle: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                      fillColor:
                                          Color.fromARGB(255, 250, 250, 250),
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
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
                                    decoration: InputDecoration(
                                      labelText: 'Pincode',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      labelStyle: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                      fillColor:
                                          Color.fromARGB(255, 250, 250, 250),
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ));
            setState(() {
              switch (index) {
                case 0:
                  break;
                case 1:
                  break;
                case 2:
                  break;
              }
            });
          },
        ),
        body: SizedBox(
            width: screenSize.width,
            child: ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 18.0, bottom: 8.0, left: 10.0),
                  child: Text("Most Browsed:", style: TextStyle(fontSize: 20)),
                ),
                SizedBox(
                  height: 300,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      MostBrowsedCard(category: "clothing"),
                      MostBrowsedCard(category: "furniture"),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 18.0, bottom: 8.0, left: 10.0),
                  child: Text("Categories:", style: TextStyle(fontSize: 20)),
                ),
                CategoryCard(category: "clothing"),
                CategoryCard(category: "furniture"),
              ],
            )));
  }
}
