import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/business_navigation_bar.dart';
import 'package:lofy_frontend/Components/error_page.dart';
import 'package:lofy_frontend/Components/loader.dart';
import 'package:lofy_frontend/Components/product_card.dart';
import 'package:lofy_frontend/Screens/business_add_product.dart';
import 'package:lofy_frontend/utils/http.utils.dart';

class BusinessProductsScreen extends StatefulWidget {
  BusinessProductsScreen({Key? key}) : super(key: key);

  @override
  State<BusinessProductsScreen> createState() => _BusinessProductsScreenState();
}

class _BusinessProductsScreenState extends State<BusinessProductsScreen> {
  var products = [];
  List<Widget> productWidgets = [];
  bool isLoading = true;
  bool hasError = false;

  void initProfile() async {
    try {
      products = (await getAuth("business/profile"))['products'];
      for (var product in products) {
        productWidgets.add(ProductCard(
          product: product,
        ));
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

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("My Products:"),
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: BusinessNavBar(index: 0),
        body: SizedBox(
            width: screenSize.width,
            child: isLoading
                ? PageLoader()
                : hasError
                    ? ErrorComponent()
                    : ListView(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(),
                        ),
                        ...productWidgets,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15),
                          child: Center(
                            child: SizedBox(
                              width: screenSize.width * 0.8,
                              height: 50,
                              child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
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
