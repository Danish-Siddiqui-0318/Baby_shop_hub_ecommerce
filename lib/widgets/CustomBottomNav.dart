// import 'package:baby_shop_hub/Pages/ProductsUser.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../Pages/HomeScreen.dart';
// import '../Pages/DetailProduct.dart';

// class CustomBottomNav extends StatelessWidget {
//   final int currentIndex;

//   const CustomBottomNav({super.key, required this.currentIndex});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 70.h, // responsive height
//       child: BottomNavigationBar(
//         backgroundColor: Color.fromARGB(255, 248, 55, 87),
//         currentIndex: currentIndex,
//         selectedItemColor: Colors.amberAccent,
//         unselectedItemColor: Colors.white,
//         type: BottomNavigationBarType.fixed,
//         selectedFontSize: 12.sp, // responsive font
//         unselectedFontSize: 11.sp,
//         iconSize: 24.sp, // responsive icons
//         onTap: (index) {
//           if (index == currentIndex) return;
//           switch (index) {
//             case 0:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (_) => const HomeScreen()),
//               );
//               break;
//             case 1:
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (_) => ProductsUser()),
//               );
//               break;
//             case 2:
//               break;
//             case 3:
//               break;
//             case 4:
//               break;
//           }
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home, size: 24.sp),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite_border, size: 24.sp),
//             label: "Products",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart, size: 24.sp),
//             label: "Cart",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search, size: 24.sp),
//             label: "Search",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings, size: 24.sp),
//             label: "Setting",
//           ),
//         ],
//       ),
//     );
//   }
// }
