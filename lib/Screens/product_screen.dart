import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/customer_navigation_bar.dart';
import 'package:lofy_frontend/Components/product_card.dart';
import 'package:lofy_frontend/Components/review_card.dart';
import 'package:lofy_frontend/utils/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key, required this.product}) : super(key: key);
  final product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Widget> reviewWidgets = <Widget>[];
  @override
  void initState() {
    super.initState();
    print("Wtf");
    bool entered = false;
    for (var review in widget.product['reviews']) {
      entered = true;
      reviewWidgets.add(ReviewCard(
          user: review['customer_name'],
          review: review['review'],
          rating: review['rating']));
    }
    if (entered) {
      reviewWidgets.add(SizedBox(height: 60));
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Hi User!"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          label: Text('Add to Cart'),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            dynamic cart = prefs.get("cart");
            if (cart == null) {
              cart = {
                'businessId': widget.product['business_id'],
                'products': [
                  {
                    "product_id": widget.product['_id'],
                    "quantity": 1,
                    "product": widget.product
                  }
                ]
              };
              showSnackBar("Product added to cart");
            } else {
              cart = json.decode(cart);
              if (widget.product['business_id'] != cart['businessId']) {
                cart = {
                  'businessId': widget.product['business_id'],
                  'products': [
                    {
                      "product_id": widget.product['_id'],
                      "quantity": 1,
                      "product": widget.product
                    }
                  ]
                };
                showSnackBar("Product added to cart");
              } else {
                bool found = false;
                for (int i = 0; i < cart['products'].length; i++) {
                  if (cart['products'][i]['product_id'] ==
                      widget.product['_id']) {
                    found = true;
                    cart['products'][i]['quantity'] += 1;
                    showSnackBar("Quantity updated");
                    break;
                  }
                }
                if (!found) {
                  cart['products'].add({
                    "product_id": widget.product['_id'],
                    "quantity": 1,
                    "product": widget.product
                  });
                  showSnackBar("Product added to cart");
                }
              }
            }
            await prefs.setString("cart", jsonEncode(cart));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: CustomerNavBar(
          index: 0,
        ),
        body: Center(
          child: SizedBox(
              width: screenSize.width,
              child: ListView(
                  children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 28.0, left: 35, right: 35),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.product['name'],
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Rating: ${widget.product['rating'] == -1 ? "-" : widget.product['rating']}/5",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                )
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Image.asset(
                            "assets/Organization.png",
                            width: screenSize.width * 0.75,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, bottom: 17),
                          child: Row(children: [
                            Text("Price:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text(
                                  "Rs. ${widget.product['price'].toString()}",
                                  style: TextStyle(fontSize: 18)),
                            ),
                          ]),
                        ),
                        widget.product['description'] != null
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, bottom: 17),
                                child: Text("Description:",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                              )
                            : Container(),
                        widget.product['description'] != null
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, bottom: 17),
                                child: Text(widget.product['description'],
                                    style: TextStyle(fontSize: 18)),
                              )
                            : Container(),
                        reviewWidgets.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, bottom: 10),
                                child: Text("Reviews:",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                              )
                            : Container(),
                      ] +
                      reviewWidgets)),
        ));
  }
}
