import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shop/pages/intro_page.dart';
import 'package:furniture_shop/components/bottom_nav_bar.dart';
import 'package:furniture_shop/controller/product_controller.dart';
import 'package:furniture_shop/db/cart_db_helper.dart';

void main() {
  //  Initialize controllers before the app starts
  Get.put(ProductController()); // now GetX can find it anywhere
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    CartDBHelper db = CartDBHelper.getinstance;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
      routes: {
        '/intropage': (context) => const IntroPage(),
        '/homepage': (context) => const BottomNavBar(), //  Main app after intro
      },
    );
  }
}
