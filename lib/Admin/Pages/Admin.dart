import 'package:baby_shop_hub/Admin/Pages/Products.dart';
import 'package:baby_shop_hub/Admin/Pages/User.dart';
import 'package:baby_shop_hub/Admin/login.dart';
import 'package:baby_shop_hub/services/auth_service.dart';
import 'package:baby_shop_hub/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Page", style: TextStyle(fontSize: 18.sp)),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFFFF3B5F)),
              child: Text(
                "Admin Menu",
                style: TextStyle(color: Colors.white, fontSize: 20.sp),
              ),
            ),
            ListTile(
              leading: Icon(Icons.production_quantity_limits, size: 22.sp),
              title: Text("Products", style: TextStyle(fontSize: 15.sp)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Products()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle, size: 22.sp),
              title: Text("Users", style: TextStyle(fontSize: 15.sp)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllUsers()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, size: 22.sp),
              title: Text("Logout", style: TextStyle(fontSize: 15.sp)),
              onTap: () {
                showLoading(context);
                _authService
                    .logout()
                    .then((value) {
                      gotoPage(Login(), context);
                      showMessage("Logout Successfully", context);
                      Navigator.pop(context);
                    })
                    .catchError((error) {
                      showMessage(error, context);
                      Navigator.pop(context);
                    });
              },
            ),
          ],
        ),
      ),

      // 👇 Welcome Animation Added
      body: Center(
        child: SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Text(
              "👋 Welcome, Admin",
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFF3B5F),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
