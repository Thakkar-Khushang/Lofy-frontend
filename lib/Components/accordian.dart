import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/loader.dart';
import 'package:lofy_frontend/utils/http.utils.dart';
import 'dart:math' as math;

import 'package:lofy_frontend/utils/snackbar.dart';

class Accordion extends StatefulWidget {
  final order;

  Accordion({required this.order});
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  List<Widget> items = [];
  List<TextEditingController> controllers = [];
  var ratings = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.order['products'].length; i++) {
      controllers.add(TextEditingController());
      ratings.add(0);
    }
  }

  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    items = [];
    for (var i = 0; i < widget.order['products'].length; i++) {
      final _formKey = GlobalKey<FormState>();
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
                  widget.order['status'] == "Order Finished" &&
                          !widget.order['products'][i]['reviewed']
                      ? Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "How would you rate this product out of 5?",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        icon: Icon(ratings[i] >= 1
                                            ? Icons.star
                                            : Icons.star_border_outlined),
                                        onPressed: () {
                                          if (!mounted) return;
                                          setState(() {
                                            ratings[i] = 1;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(ratings[i] >= 2
                                            ? Icons.star
                                            : Icons.star_border_outlined),
                                        onPressed: () {
                                          if (!mounted) return;
                                          setState(() {
                                            ratings[i] = 2;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(ratings[i] >= 3
                                            ? Icons.star
                                            : Icons.star_border_outlined),
                                        onPressed: () {
                                          if (!mounted) return;
                                          setState(() {
                                            ratings[i] = 3;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(ratings[i] >= 4
                                            ? Icons.star
                                            : Icons.star_border_outlined),
                                        onPressed: () {
                                          if (!mounted) return;
                                          setState(() {
                                            ratings[i] = 4;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(ratings[i] >= 5
                                            ? Icons.star
                                            : Icons.star_border_outlined),
                                        onPressed: () {
                                          if (!mounted) return;
                                          setState(() {
                                            ratings[i] = 5;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Add Review:",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              TextFormField(
                                controller: controllers[i],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Review',
                                ),
                                maxLines: 4,
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      if (ratings[i] == 0) {
                                        showSnackBar("Please rate the product");
                                      } else if (ratings[i] > 0) {
                                        showLoader();
                                        var body = {
                                          "rating": ratings[i],
                                          "review": controllers[i].text,
                                          "orderId": widget.order['_id'],
                                        };
                                        var resp = await postAuth(
                                            "product/review/${widget.order['products'][i]['_id']}",
                                            jsonEncode(body));
                                        if (resp['message'] ==
                                            "Review added successfully") {
                                          if (!mounted) return;
                                          setState(() {
                                            widget.order['products'][i]
                                                ['reviewed'] = true;
                                            widget.order['products'][i]
                                                    ['review'] =
                                                controllers[i].text;
                                            widget.order['products'][i]
                                                ['rating'] = ratings[i];
                                          });
                                        }
                                        closeLoader();
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Submit",
                                  ))
                            ],
                          ),
                        )
                      : widget.order['products'][i]['reviewed']
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Rating: " +
                                          widget.order['products'][i]['rating']
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Review: " +
                                          widget.order['products'][i]['review'],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container()
                ]),
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
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
                                  "Order Status: " + widget.order['status'],
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
