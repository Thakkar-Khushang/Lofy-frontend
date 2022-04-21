import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/accordian.dart';
import 'package:lofy_frontend/Components/customer_navigation_bar.dart';

class CustomerOrdersScreen extends StatefulWidget {
  CustomerOrdersScreen({Key? key}) : super(key: key);

  @override
  State<CustomerOrdersScreen> createState() => _CustomerOrdersScreenState();
}

class _CustomerOrdersScreenState extends State<CustomerOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("My Orders:"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        bottomNavigationBar: CustomerNavBar(
          index: 2,
        ),
        body: SizedBox(
            width: screenSize.width,
            child: ListView(children: [
              Accordion(order: {
                "business_name": "Organization Name",
                "products": [
                  {"name": "Product 1", "price": "100", "quantity": "1"},
                  {"name": "Product 2", "price": "200", "quantity": "2"},
                  {"name": "Product 3", "price": "300", "quantity": "3"},
                ]
              })
            ])));
  }
}
