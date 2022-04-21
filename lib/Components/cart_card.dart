import 'package:flutter/material.dart';

typedef void ChangeQuantity(int index, int quantity);

class CartCard extends StatefulWidget {
  CartCard(
      {Key? key,
      required this.product,
      required this.quantity,
      required this.index,
      required this.changeQuantity})
      : super(key: key);
  final product;
  final quantity;
  final index;
  final ChangeQuantity changeQuantity;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17.0, top: 8, right: 17),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 60,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 26.0, top: 18, right: 8, bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product['name'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              "Rs. " + widget.product['price'].toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          "Rating: ${widget.product['rating'] == -1 ? "-" : widget.product['rating'].toString()}/5",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                      ),
                      Row(children: [
                        IconButton(
                          iconSize: 20,
                          icon: Icon(
                            Icons.remove,
                          ),
                          onPressed: () {
                            if (widget.quantity - 1 > 0) {
                              var quantity = widget.quantity - 1;
                              widget.changeQuantity(widget.index, quantity);
                            }
                          },
                        ),
                        Text(widget.quantity.toString()),
                        IconButton(
                          iconSize: 20,
                          icon: Icon(Icons.add),
                          onPressed: () {
                            widget.changeQuantity(
                                widget.index, widget.quantity + 1);
                          },
                        ),
                      ])
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
