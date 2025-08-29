import 'package:baby_shop_hub/Pages/HomeScreen.dart';
import 'package:baby_shop_hub/Pages/ProductsUser.dart';
import 'package:baby_shop_hub/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class NavigationPage extends StatefulWidget {
  NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) => Scaffold(
        body: IndexedStack(
          index: appProvider.currentIndex,
          children: [
            // Your different pages go here
            HomeScreen(),
            ProductsUser(),
            HomeScreen(),
            ProductsUser(),
            HomeScreen(),
          
            
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 248, 55, 87),
          currentIndex: appProvider.currentIndex,
          selectedItemColor: Colors.amberAccent,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12.sp, // responsive font
          unselectedFontSize: 11.sp,
          iconSize: 24.sp, // responsive icons
          onTap: appProvider.updateIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 24.sp),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border, size: 24.sp),
              label: "Products",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, size: 24.sp),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 24.sp),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 24.sp),
              label: "Setting",
            ),
          ],
        ),
      ),
    );
  }
}