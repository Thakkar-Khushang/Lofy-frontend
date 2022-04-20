import 'package:flutter/material.dart';
import 'package:lofy_frontend/Components/category_business_card.dart';

class CategoryBusinessesScreen extends StatefulWidget {
  const CategoryBusinessesScreen({Key? key, required this.category})
      : super(key: key);
  final category;

  @override
  State<CategoryBusinessesScreen> createState() =>
      _CategoryBusinessesScreenState();
}

class _CategoryBusinessesScreenState extends State<CategoryBusinessesScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Hi User!"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: "My Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
          currentIndex: 0,
          onTap: (index) {
            setState(() {
              switch (index) {
                case 0:
                  break;
                case 1:
                  break;
                case 2:
                  break;
              }
            });
          },
        ),
        body: SizedBox(
            width: screenSize.width,
            child: ListView(children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 18.0, bottom: 8.0, left: 20.0),
                child: Text("${widget.category}:",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ),
              CategoryBusinessCard(
                  category: widget.category, speciality: "Papad")
            ])));
  }
}
