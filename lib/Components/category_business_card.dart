import 'package:flutter/material.dart';

class CategoryBusinessCard extends StatelessWidget {
  const CategoryBusinessCard(
      {Key? key, required this.category, required this.speciality})
      : super(key: key);
  final category;
  final speciality;

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
              child: Image.asset('assets/$category.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Organization Name",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    category,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
