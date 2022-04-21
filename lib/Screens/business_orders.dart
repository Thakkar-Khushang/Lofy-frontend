import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/accordian.dart';
import 'package:lofy_frontend/Components/business_navigation_bar.dart';
import 'package:lofy_frontend/Components/business_order_accordian.dart';

class BusinessOrdersScreen extends StatefulWidget {
  BusinessOrdersScreen({Key? key}) : super(key: key);

  @override
  State<BusinessOrdersScreen> createState() => _BusinessOrdersScreenState();
}

class _BusinessOrdersScreenState extends State<BusinessOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("My Orders:"),
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: BusinessNavBar(index: 1),
        body: SizedBox(
            width: screenSize.width,
            child: ListView(children: [
              BusinessAccordion(order: {
                "_id": "6252baddfd0a27be58115094",
                "status": "Order sent to vendor",
                "customer_id": "62527be046f31e2d561380be",
                "business_id": "625295f45b8aaca2ae898301",
                "products": [
                  {
                    "_id": "6252b9a16fd7d6f4523db750",
                    "name": "Test Product 2",
                    "description": "Test Description",
                    "price": 1234456,
                    "rating": -1,
                    "reviews": [],
                    "quantity": 1
                  }
                ],
                "address": "Test Address",
                "__v": 0,
                "business_name": "Test Business"
              }, index: 1)
            ])));
  }
}
