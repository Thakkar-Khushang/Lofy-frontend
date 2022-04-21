import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/business_navigation_bar.dart';
import 'package:lofy_frontend/Components/product_card.dart';
import 'package:lofy_frontend/Screens/business_add_product.dart';

class BusinessProductsScreen extends StatefulWidget {
  BusinessProductsScreen({Key? key}) : super(key: key);

  @override
  State<BusinessProductsScreen> createState() => _BusinessProductsScreenState();
}

class _BusinessProductsScreenState extends State<BusinessProductsScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("My Orders:"),
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: BusinessNavBar(index: 0),
        body: SizedBox(
            width: screenSize.width,
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(),
              ),
              // ProductCard(),
              // ProductCard(),
              // ProductCard(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: Center(
                  child: SizedBox(
                    width: screenSize.width * 0.8,
                    height: 50,
                    child: ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BusinessAddProductScreen()));
                        },
                        icon: Icon(Icons.add),
                        label: Text("Add Product")),
                  ),
                ),
              ),
            ])));
  }
}
