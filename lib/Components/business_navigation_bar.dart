import 'package:flutter/material.dart';
import 'package:lofy_frontend/Screens/business_orders.dart';
import 'package:lofy_frontend/Screens/business_products.dart';
import 'package:lofy_frontend/Screens/business_profile.dart';
import 'package:lofy_frontend/utils/navigator.dart';

class BusinessNavBar extends StatefulWidget {
  BusinessNavBar({Key? key, this.index = 0}) : super(key: key);
  final index;

  @override
  State<BusinessNavBar> createState() => _NavBarState();
}

class _NavBarState extends State<BusinessNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.sell),
          label: "My Products",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: "My Orders",
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
              pushReplaceWithoutAnimation(BusinessProductsScreen());
              break;
            case 1:
              pushReplaceWithoutAnimation(BusinessOrdersScreen());
              break;
            case 2:
              pushReplaceWithoutAnimation(BusinessProfileScreen());
              break;
            default:
          }
        }
      },
    );
  }
}
