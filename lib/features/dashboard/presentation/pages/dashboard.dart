import 'package:flutter/material.dart';

import 'package:brik/features/product/presentation/pages/products.dart';

class DashboardPage extends StatefulWidget {
  static const route = '/dashboard';
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {

  int selectedIndex = 0;

  List<Widget> widgets = [
    const ProductsScreen(),
    const SizedBox(),
  ];

  void onItemTapped(int i) {
    setState(() => selectedIndex = i);
  }

  @override 
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.online_prediction_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: onItemTapped,
      ),
    );
  }

}