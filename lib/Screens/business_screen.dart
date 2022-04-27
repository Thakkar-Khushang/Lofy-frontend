import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/customer_navigation_bar.dart';
import 'package:lofy_frontend/Components/error_page.dart';
import 'package:lofy_frontend/Components/loader.dart';
import 'package:lofy_frontend/Components/product_card.dart';
import 'package:lofy_frontend/utils/http.utils.dart';

class BusinessScreen extends StatefulWidget {
  BusinessScreen({Key? key, required this.business}) : super(key: key);
  final business;

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  var productWidgets = <Widget>[];
  bool hasError = false;
  bool loading = true;
  var products = [];
  var business;

  void initBusinessScreen() async {
    try {
      var resp =
          await getAuth("customer/see-business/${widget.business['_id']}");
      products = resp['products'];
      business = resp['business'];
    } catch (e) {
      print(e);
       if (!mounted) return;
      setState(() {
        hasError = true;
      });
    }
    for (var product in products) {
      productWidgets.add(ProductCard(product: product));
    }
     if (!mounted) return;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initBusinessScreen();
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
        body: Center(
          child: SizedBox(
              width: screenSize.width,
              child: hasError
                  ? ErrorComponent()
                  : loading
                      ? PageLoader()
                      : ListView(
                          children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 28.0),
                                  child: Center(
                                    child: Text(
                                      widget.business['name'],
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Image.asset(
                                    "assets/Organization.png",
                                    width: screenSize.width * 0.75,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 17),
                                  child: Text("Category:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 17),
                                  child: Text(business['category'],
                                      style: TextStyle(
                                        fontSize: 18,
                                      )),
                                ),
                                business['description'] != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, bottom: 17),
                                        child: Text("Description:",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600)),
                                      )
                                    : Container(),
                                business['description'] != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, bottom: 17),
                                        child: Text(business['description'],
                                            style: TextStyle(
                                              fontSize: 18,
                                            )),
                                      )
                                    : Container(),
                                business['specialization'] != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, bottom: 17),
                                        child: Text("Specialization:",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600)),
                                      )
                                    : Container(),
                                business['specialization'] != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, bottom: 17),
                                        child: Text(business['specialization'],
                                            style: TextStyle(
                                              fontSize: 18,
                                            )),
                                      )
                                    : Container(),
                                business['address'] != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, bottom: 17),
                                        child: Text("Address:",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600)),
                                      )
                                    : Container(),
                                business['address'] != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, bottom: 17),
                                        child: Text(
                                            business['address']['line1'] +
                                                ", " +
                                                business['address']['line2'] +
                                                ", " +
                                                business['address']['city'] +
                                                ", " +
                                                business['address']['state'] +
                                                " - " +
                                                business['address']['zip'],
                                            style: TextStyle(
                                              fontSize: 18,
                                            )),
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 17),
                                  child: Text("Email:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 17),
                                  child: Text(business['email'],
                                      style: TextStyle(
                                        fontSize: 18,
                                      )),
                                ),
                                business['socialMediaLink'] != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, bottom: 17),
                                        child: Text("Social Media Link:",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600)),
                                      )
                                    : Container(),
                                business['socialMediaLink'] != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, bottom: 17),
                                        child: Text(business['socialMediaLink'],
                                            style: TextStyle(
                                              fontSize: 18,
                                            )),
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 17),
                                  child: Text(
                                      productWidgets.isNotEmpty
                                          ? "Products Sold:"
                                          : "No Products Listed",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600)),
                                )
                              ] +
                              productWidgets)),
        ));
  }
}
