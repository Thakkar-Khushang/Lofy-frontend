import 'package:flutter/material.dart';
import 'package:lofy_frontend/Screens/business_screen.dart';

class CategoryBusinessCard extends StatelessWidget {
  const CategoryBusinessCard({Key? key, required this.business})
      : super(key: key);
  final business;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BusinessScreen(
              business: business,
            ),
          ),
        );
      },
      child: Padding(
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
                child: Image.asset(
                    'assets/${business['category'].toLowerCase()}.png'),
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
                      business['name'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      business['specialization'] ?? "",
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
      ),
    );
  }
}
