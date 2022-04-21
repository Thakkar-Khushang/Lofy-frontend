import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/accordian.dart';
import 'package:lofy_frontend/Components/customer_navigation_bar.dart';
import 'package:lofy_frontend/Components/error_page.dart';
import 'package:lofy_frontend/Components/loader.dart';
import 'package:lofy_frontend/utils/http.utils.dart';
import 'package:lofy_frontend/utils/snackbar.dart';

class CustomerOrdersScreen extends StatefulWidget {
  CustomerOrdersScreen({Key? key}) : super(key: key);

  @override
  State<CustomerOrdersScreen> createState() => _CustomerOrdersScreenState();
}

class _CustomerOrdersScreenState extends State<CustomerOrdersScreen> {
  var orders;
  bool _isLoading = true;
  bool hasError = false;
  List<Widget> _orderList = [];

  void initOrders() async {
    try {
      orders = (await getAuth("customer/get-orders"))['orders'];
      for (var order in orders) {
        _orderList.add(
          Accordion(
            order: order,
          ),
        );
      }
    } catch (e) {
      setState(() {
        hasError = true;
      });
    }
    setState(() {
      _isLoading = false;
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
            child: _isLoading
                ? PageLoader()
                : hasError
                    ? ErrorComponent()
                    : ListView(children: [..._orderList])));
  }
}
