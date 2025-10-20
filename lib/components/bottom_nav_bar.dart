import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:furniture_shop/pages/cart_page.dart';
import 'package:furniture_shop/pages/favorite_page.dart';
import 'package:furniture_shop/pages/product_home_page.dart';
import 'package:furniture_shop/pages/profile_page.dart';
import 'package:furniture_shop/pages/scan_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // keeps track of which bottom nav item is selected
  int _selectedIndex = 0;

  // list of pages corresponding to each bottom nav item (exclude CartPage)
  final List<Widget> _pages = [
    ProductHomePage(),
    FavoritePage(),
    ScanPage(),
    ProfilePage(),
  ];

  // this function updates the selected index or navigates to cart
  void _navigateBottomBar(int index) {
    if (index == 3) {
      // Cart icon tapped -> navigate separately without bottom nav
      Get.to(() => const CartPage());
    } else {
      // Adjust selected index for other pages
      setState(() {
        // if index > 3 (cart removed), subtract 1 to match _pages list
        _selectedIndex = index > 3 ? index - 1 : index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // displays the currently selected page
      body: _pages[_selectedIndex],

      // bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex >= 3
            ? 4 //added 4 so that when we clicked profile page it highlights it
            : _selectedIndex, // adjust for cart so that it avoid crash
        type: BottomNavigationBarType.fixed,
        onTap: _navigateBottomBar, // call function to update selected index
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/home.png", width: 24, height: 24),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/favourite.png",
                width: 24, height: 24),
            label: "Favourite",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/scan.png", width: 24, height: 24),
            label: "Scan",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/cart.png", width: 24, height: 24),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/user.png", width: 24, height: 24),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
