import 'package:flutter/material.dart';

class OrderMessage extends StatelessWidget {
  const OrderMessage({Key? key, required this.success}) : super(key: key);
  final bool success;

  @override
  Widget build(BuildContext context) {
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 5,
                    offset: Offset(3, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 54,
                        right: 54,
                        top: success ? 20 : 0,
                      ),
                      child: Text(
                        success
                            ? 'Your order was successfully placed'
                            : "Your order was not successful",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    success
                        ? Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 21),
                            child: Text(
                              'Transaction ID: asnf124kjanx',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              )),
          success
              ? Positioned(top: -85, child: Image.asset("assets/logo.png"))
              : Container()
        ]);
  }
}
