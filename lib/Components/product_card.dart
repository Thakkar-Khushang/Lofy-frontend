import 'package:flutter/material.dart';
import 'package:lofy_frontend/Screens/product_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);
  final product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(
              product: product,
            ),
          ),
        )
      },
      child: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 17.0, top: 8, right: 17, bottom: 7),
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.black),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Image.asset('assets/pickleJar.png'),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          product['name'],
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "Rs. " + product['price'].toString(),
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
