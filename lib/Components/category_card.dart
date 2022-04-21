import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, required this.category}) : super(key: key);
  final category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17.0, top: 8, right: 17),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image.asset('assets/${category.toLowerCase()}.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                category,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
