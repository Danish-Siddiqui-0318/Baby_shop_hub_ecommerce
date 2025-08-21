import 'package:flutter/material.dart';

import '../widgets/CustomBottomNav.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist")),
      body: const Center(child: Text("Wishlist Page")),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
    );
  }
}
