import 'package:carrent/core/Color/color.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key, required this.navigationShell, required this.router});

  final StatefulNavigationShell navigationShell;
  final GoRouter router; // Add a reference to the GoRouter

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;

  // Function to map the current route to the navigation bar index
  int _getSelectedIndexFromRoute(String route) {
    if (route.startsWith('/home')) {
      return 0;
    } else if (route.startsWith('/category')) {
      return 1;
    } else if (route.startsWith('/rentWay')) {
      return 2;
    } else if (route.startsWith('/profile')) {
      return 3;
    } else if (route.startsWith('/coupons')) {
      return 4;
    }
    return 0; // Default to home if no match
  }

  void _goBranch(int index) {
    // Navigate to the desired branch based on index
    setState(() {
      widget.navigationShell.goBranch(
        index,
        initialLocation: index == widget.navigationShell.currentIndex,
      );
      // Update the selected index based on the tapped index
      selectedIndex = index; 
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the current location from the GoRouter
    final String location = widget.router.routerDelegate.currentConfiguration.uri.toString();

    // Update the selected index based on the current route
    selectedIndex = _getSelectedIndexFromRoute(location);

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: CircleNavBar(
        activeIcons: [
          Icon(Icons.home, size: 23.w, color: tdBlueLight),
          Icon(Icons.category_rounded, size: 23.w, color: tdBlueLight),
          Icon(Icons.car_rental_sharp, size: 23.w, color: tdBlueLight),
          Icon(Icons.person, size: 23.w, color: tdBlueLight),
          Icon(Icons.percent, size: 23.w, color: tdBlueLight),
        ],
        inactiveIcons: [
          Text(
            "Home",
            style: TextStyle(
                color: tdBlueLight,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "Category",
            style: TextStyle(
                color: tdBlueLight,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "RentWay",
            style: TextStyle(
                color: tdBlueLight,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Profile',
            style: TextStyle(
                color: tdBlueLight,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'Promotion',
            style: TextStyle(
                color: tdBlueLight,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold),
          ),
        ],
        color: tdWhite,
        circleColor: tdWhite,
        height: 40.h,
        circleWidth: 50,
        shadowColor: tdBlack,
        circleShadowColor: tdBlack,
        elevation: 10,
        gradient: null,
        circleGradient: null,
        tabCurve: Curves.easeInOut,
        onTap: (index) {
          setState(() {
            _goBranch(index);
          });
        },
        activeIndex: selectedIndex,
      ),
    );
  }
}
