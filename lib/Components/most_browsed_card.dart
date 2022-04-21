import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MostBrowsedCard extends StatelessWidget {
  const MostBrowsedCard({Key? key, required this.business}) : super(key: key);
  final business;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
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
          child: Stack(alignment: Alignment.topRight, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/Organization.png', height: 200),
                Text(
                  business["name"],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  business["category"],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                    'assets/${business["category"].toLowerCase()}.png',
                    height: 50),
              ),
            )
          ])),
    );
  }
}
