import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/cart_card.dart';
import 'package:lofy_frontend/Components/category_business_card.dart';
import 'package:lofy_frontend/Components/customer_navigation_bar.dart';
import 'package:lofy_frontend/Components/loader.dart';
import 'package:lofy_frontend/Components/order_message.dart';
import 'package:lofy_frontend/utils/http.utils.dart';
import 'package:lofy_frontend/utils/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCartScreen extends StatefulWidget {
  MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  bool orderPlaced = false;
  bool emptyCart = false;
  bool loading = true;
  List<Widget> cartWidgets = <Widget>[];
  dynamic cart;

  void deleteProduct(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cart = prefs.get("cart");
    cart = jsonDecode(cart);
    cart['products'].removeAt(index);
    prefs.setString("cart", json.encode(cart));
    if (!mounted) return;
    setState(() {
      cartWidgets = <Widget>[];
      for (int i = 0; i < cart['products'].length; i++) {
        cartWidgets.add(CartCard(
            product: cart['products'][i]['product'],
            quantity: cart['products'][i]['quantity'],
            index: i,
            changeQuantity: changeQuantity,
            delete: deleteProduct));
      }
      if (cart['products'].length == 0) {
        cart = null;
        prefs.remove("cart");
        emptyCart = true;
      }
    });
  }

  void changeQuantity(int index, int quantity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cart = prefs.get("cart");
    cart = jsonDecode(cart);
    cart['products'][index]['quantity'] = quantity;
    prefs.setString("cart", json.encode(cart));
    if (!mounted) return;
    setState(() {
      cartWidgets = <Widget>[];
      for (int i = 0; i < cart['products'].length; i++) {
        cartWidgets.add(CartCard(
          product: cart['products'][i]['product'],
          quantity: cart['products'][i]['quantity'],
          index: i,
          changeQuantity: changeQuantity,
          delete: deleteProduct,
        ));
      }
    });
  }

  void initCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cart = prefs.get("cart");
    if (cart == null) {
      if (!mounted) return;
      setState(() {
        emptyCart = true;
      });
    } else {
      cart = jsonDecode(cart);
      cartWidgets = <Widget>[];
      for (int i = 0; i < cart['products'].length; i++) {
        cartWidgets.add(CartCard(
            product: cart['products'][i]['product'],
            quantity: cart['products'][i]['quantity'],
            index: i,
            changeQuantity: changeQuantity,
            delete: deleteProduct));
      }
      if (!mounted) return;
      setState(() {
        loading = false;
      });
    }
    if (!mounted) return;
    setState(() {
      loading = false;
    });
  }

  void placeOrder() async {
    var order = cart;
    for (int i = 0; i < cart['products'].length; i++) {
      order['products'][i].remove('product');
    }
    try {
      showLoader();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var resp = await postAuth("customer/place-order", jsonEncode(order));
      showSnackBar(resp['message']);
      if (resp['message'] == "Order placed successfully") {
        closeLoader();
        await prefs.remove("cart");
        if (!mounted) return;
        setState(() {
          orderPlaced = true;
          emptyCart = true;
        });
      }
    } catch (e) {
      closeLoader();
      showSnackBar("Something went wrong");
    }
  }

  @override
  void initState() {
    super.initState();
    initCart();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("My Cart:"),
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: orderPlaced || emptyCart
            ? null
            : FloatingActionButton.extended(
                backgroundColor: Colors.black,
                onPressed: () {
                  placeOrder();
                },
                label: Text("Buy Now")),
        bottomNavigationBar: CustomerNavBar(
          index: 1,
        ),
        body: orderPlaced
            ? SizedBox(
                width: screenSize.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [OrderMessage(success: true)]),
              )
            : SizedBox(
                width: screenSize.width,
                child: emptyCart
                    ? SizedBox(
                        width: screenSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/cartPeep.png"),
                            Text(
                              "Oops! Your cart is empty",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ))
                    : loading
                        ? PageLoader()
                        : ListView(children: [
                            ...cartWidgets,
                          ])));
  }
}
