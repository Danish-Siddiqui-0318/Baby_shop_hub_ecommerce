import 'package:baby_shop_hub/Admin/Pages/AddProducts.dart';
import 'package:baby_shop_hub/Admin/Pages/Admin.dart';
import 'package:baby_shop_hub/Admin/Pages/Products.dart';
import 'package:baby_shop_hub/Admin/Pages/User.dart';
import 'package:baby_shop_hub/Admin/Pages/auth_page.dart';
import 'package:baby_shop_hub/Admin/Pages/signup.dart';
import 'package:baby_shop_hub/Pages/DetailProduct.dart';
import 'package:baby_shop_hub/Pages/HomeScreen.dart';
import 'package:baby_shop_hub/provider/app_provider.dart';
import 'package:baby_shop_hub/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Pages/IntroScreen.dart';
import 'Pages/OnBoardScreen.dart';
import 'Pages/ProductsUser.dart';
import 'firebase_options.dart';
import 'Admin/Pages/forgotPassword.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://rzbaxrlosmshqeeocmnf.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ6YmF4cmxvc21zaHFlZW9jbW5mIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU1Njc5NDEsImV4cCI6MjA3MTE0Mzk0MX0.4pIx7K2THPiPoGHm37HyYqCtTwggjn5FHul_HF450Qw",
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(debugShowCheckedModeBanner: false, home: child);
      },
      child: AuthGate(),
    );
  }
}
