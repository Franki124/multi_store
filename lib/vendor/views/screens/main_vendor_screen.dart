import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_store/vendor/views/screens/earnings_screen.dart';
import 'package:multi_store/vendor/views/screens/edit_product_screen.dart';
import 'package:multi_store/vendor/views/screens/upload_screen.dart';
import 'package:multi_store/vendor/views/screens/vendor_logout_screen.dart';
import 'package:multi_store/vendor/views/screens/vendor_orders_screens.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({Key? key}) : super(key: key);

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    EarningsScreen(),
    UploadScreen(),
    EditProductScreen(),
    VendorOrderScreen(),
    VendorLogoutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          onTap: ((value) {
            setState(() {
              _pageIndex = value;
            });
          }),
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.blue.shade900,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money_outlined), label: "Earnings"),
            BottomNavigationBarItem(
                icon: Icon(Icons.upload_outlined), label: "Upload"),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: "Edit"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: "Orders"),
            BottomNavigationBarItem(
                icon: Icon(Icons.logout_outlined), label: "Log out"),
          ]),
      body: _pages[_pageIndex],
    );
  }
}
