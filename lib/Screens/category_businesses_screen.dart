import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/category_business_card.dart';
import 'package:lofy_frontend/Components/customer_navigation_bar.dart';

class CategoryBusinessesScreen extends StatefulWidget {
  const CategoryBusinessesScreen(
      {Key? key, required this.businesses, required this.category})
      : super(key: key);
  final businesses;
  final category;

  @override
  State<CategoryBusinessesScreen> createState() =>
      _CategoryBusinessesScreenState();
}

class _CategoryBusinessesScreenState extends State<CategoryBusinessesScreen> {
  var businessWidgets = <Widget>[];
  @override
  void initState() {
    super.initState();
    for (var business in widget.businesses) {
      businessWidgets.add(CategoryBusinessCard(business: business));
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
        bottomNavigationBar: CustomerNavBar(
          index: 0,
        ),
        body: SizedBox(
            width: screenSize.width,
            child: ListView(
                children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 18.0, bottom: 8.0, left: 20.0),
                        child: Text("${widget.category}:",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                      ),
                    ] +
                    businessWidgets)));
  }
}
