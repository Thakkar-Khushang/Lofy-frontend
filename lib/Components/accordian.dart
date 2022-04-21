import 'package:flutter/material.dart';
import 'dart:math' as math;

class Accordion extends StatefulWidget {
  final order;

  Accordion({required this.order});
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    for (var i = 0; i < widget.order['products'].length; i++) {
      items.add(
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.order['products'][i]['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rs ${widget.order['products'][i]['price'].toString()}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Quantity: ${widget.order['products'][i]['quantity'].toString()}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: Column(children: [
          ListTile(
            title: Text(widget.order["business_name"],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                )),
            trailing: IconButton(
              icon: Transform.rotate(
                angle: _showContent ? -math.pi / 2 : math.pi / 2,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              onPressed: () {
                if (mounted) {
                  setState(() {
                    _showContent = !_showContent;
                  });
                }
              },
            ),
          ),
          _showContent
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Transaction ID: smKXMCkxmqw1S",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Order Status: Order Accepted",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
                                )),
                          ),
                        ] +
                        items,
                  ),
                )
              : Container()
        ]),
      ),
    );
  }
}
