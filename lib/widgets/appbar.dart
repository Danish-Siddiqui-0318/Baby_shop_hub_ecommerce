import 'package:baby_shop_hub/Admin/Pages/login.dart';
import 'package:baby_shop_hub/services/auth_service.dart';
import 'package:baby_shop_hub/services/product_service.dart';
import 'package:baby_shop_hub/utils/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OwnAppBar extends StatefulWidget {
  OwnAppBar({super.key});

  @override
  State<OwnAppBar> createState() => _OwnAppBarState();
}

class _OwnAppBarState extends State<OwnAppBar> {
  ProductService _productService = ProductService();

  AuthService _authService = AuthService();

  FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, dynamic>? _userData = {};

  getUserData() {
    print("function called");
    _authService
        .getUsersDetails()
        .then((data) {
          print(data);
          setState(() {
            _userData = data;
          });
        })
        .catchError((error) {
          print("Error fetching user data: $error");
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: const Icon(Icons.menu, color: Colors.black),
      centerTitle: true,
      title: Image.network(
        "https://i.ibb.co/qMhT9ZhV/logo.png",
        height: 170.h,
        fit: BoxFit.contain,
      ),
      actions: [
        CircleAvatar(
          child: CachedNetworkImage(
            imageUrl: _userData?['profile_pic'] ?? '',
            imageBuilder: (context, imageProvider) =>
                CircleAvatar(backgroundImage: imageProvider, radius: 18.r),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        IconButton(
          onPressed: () {
            _authService.logout();
            gotoPage(Login(), context);
          },
          icon: Icon(Icons.logout),
        ),
      ],
    );
  }
}
