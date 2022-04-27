import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/accordian.dart';
import 'package:lofy_frontend/Components/business_navigation_bar.dart';
import 'package:lofy_frontend/Components/business_order_accordian.dart';
import 'package:lofy_frontend/Components/error_page.dart';
import 'package:lofy_frontend/Components/loader.dart';
import 'package:lofy_frontend/utils/http.utils.dart';

class BusinessOrdersScreen extends StatefulWidget {
  BusinessOrdersScreen({Key? key}) : super(key: key);

  @override
  State<BusinessOrdersScreen> createState() => _BusinessOrdersScreenState();
}

class _BusinessOrdersScreenState extends State<BusinessOrdersScreen> {
  var orders;

  bool loading = true;
  bool hasError = false;

  List<Widget> _ordersList = [];
  void initOrders() async {
    try {
      var resp = await getAuth("business/orders");
      orders = resp['orders'];
      if (orders.length > 0) {
        if (!mounted) return;
        setState(() {
          _ordersList = [];
          for (var i = 0; i < orders.length; i++) {
            _ordersList.add(
              BusinessAccordion(
                order: orders[i],
                id: orders[i]['_id'].toString().substring(0, 6),
              ),
            );
          }
        });
      }
    } catch (e) {
      print(e);
      hasError = true;
    }
    if (!mounted) return;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initOrders();
  }

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
            child: loading
                ? PageLoader()
                : hasError
                    ? ErrorComponent()
                    : ListView(children: [
                        ..._ordersList.reversed,
                      ])));
  }
}
