import 'package:ayssoft/app/core/constant/color.dart';
import 'package:ayssoft/app/ui/screens/Card/index.dart';
import 'package:ayssoft/app/ui/screens/Favorite/index.dart';
import 'package:ayssoft/app/ui/screens/Home/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [
    MyHomePage(title: 'Dummy Json'),  
    CartPage(), 
    FavoritePage(), 
  ];
  final List<NavigationDestination> _destinations = const [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Ana Sayfa',
    ),
    NavigationDestination(
      icon: Icon(Icons.shopping_cart_outlined), 
      selectedIcon: Icon(Icons.shopping_cart), 
      label: 'Sepet', 
    ),
    NavigationDestination(
      icon: Icon(Icons.favorite_border_outlined), 
      selectedIcon: Icon(Icons.favorite), 
      label: 'Favoriler', 
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1.r,
              blurRadius: 10.r,
              offset: Offset(0, -3.h), 
            ),
          ],
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: Colors.white,
            indicatorColor: Colors.grey.shade200,
            iconTheme: WidgetStateProperty.resolveWith((states) {
              return states.contains(WidgetState.selected)
                  ? const IconThemeData(color: AppColors.primary)
                  : const IconThemeData(color: Colors.grey);
            }),
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              return states.contains(WidgetState.selected)
                  ? const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold)
                  : const TextStyle(color: Colors.grey);
            }),
          ),
          child: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() => _currentIndex = index);
            },
            destinations: _destinations,
          ),
        ),
      ),
    );
  }
}