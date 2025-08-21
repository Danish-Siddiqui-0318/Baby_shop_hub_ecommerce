import 'package:flutter/material.dart';

import '../Pages/HomeScreen.dart';
import '../Pages/WishlistScreen.dart';

// import 'package:first_firebase_app/Admin/CartScreen.dart';
// import 'package:first_firebase_app/Admin/SearchScreen.dart';
// import 'package:first_firebase_app/Admin/SettingScreen.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Colors.pinkAccent,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == currentIndex) return; // Avoid reloading same page
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const WishlistScreen()),
            );
            break;
          case 2:
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (_) => const CartScreen()),
            // );
            break;
          case 3:
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (_) => const SearchScreen()),
            // );
            break;
          case 4:
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (_) => const SettingScreen()),
            // );
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Wishlist"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
      ],
    );
  }
}
