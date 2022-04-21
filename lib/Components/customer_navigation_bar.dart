import 'package:flutter/material.dart';
import 'package:lofy_frontend/Screens/business_orders.dart';
import 'package:lofy_frontend/Screens/business_products.dart';
import 'package:lofy_frontend/Screens/business_profile.dart';
import 'package:lofy_frontend/Screens/customer_profile.dart';
import 'package:lofy_frontend/Screens/home_page.dart';
import 'package:lofy_frontend/Screens/my_cart.dart';
import 'package:lofy_frontend/utils/navigator.dart';

class CustomerNavBar extends StatefulWidget {
  CustomerNavBar({Key? key, this.index = 0}) : super(key: key);
  final index;

  @override
  State<CustomerNavBar> createState() => _NavBarState();
}

class _NavBarState extends State<CustomerNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      currentIndex: widget.index,
      onTap: (index) {
        if (widget.index != index) {
          switch (index) {
            case 0:
              pushReplaceWithoutAnimation(MyHomePage());
              break;
            case 1:
              pushReplaceWithoutAnimation(MyCartScreen());
              break;
            case 2:
              pushReplaceWithoutAnimation(CustomerProfileScreen());
              break;
            default:
          }
        }
      },
    );
  }
}
