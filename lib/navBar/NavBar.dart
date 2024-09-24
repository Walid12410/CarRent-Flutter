import 'package:carrent/CarCategoryPage/CategoryPage.dart';
import 'package:carrent/Color/color.dart';
import 'package:carrent/CompanyCarPage/CompanyPage.dart';
import 'package:carrent/ProfilePage/ProfilePage.dart';
import 'package:carrent/PromotionPage/PromotionPage.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../HomePage/HomePage.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    CarCategoryPage(),
    CompanyPage(),
    ProfilePage(),
    PromotionPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CircleNavBar(
        activeIcons: [
          Icon(Icons.home,size: 23.w,color: tdBlueLight,),
          Icon(Icons.category_rounded,size: 23.w,color: tdBlueLight),
          Icon(Icons.car_rental_sharp,size: 23.w,color: tdBlueLight),
          Icon(Icons.person,size: 23.w,color: tdBlueLight),
          Icon(Icons.percent,size: 23.w,color: tdBlueLight),
        ],
        inactiveIcons:  [
          Text(
            "Home",
            style: TextStyle(color: tdBlueLight,fontSize: 10.sp,fontWeight: FontWeight.bold),
          ),
          Text(
            "Category",
            style: TextStyle(color: tdBlueLight,fontSize: 10.sp,fontWeight: FontWeight.bold),
          ),
          Text(
            "RentWay",
            style: TextStyle(color: tdBlueLight,fontSize: 10.sp,fontWeight: FontWeight.bold),
          ),
          Text(
            'Profile',
            style: TextStyle(color: tdBlueLight,fontSize: 10.sp,fontWeight: FontWeight.bold),
          ),
          Text(
            'Promotion',
            style: TextStyle(color: tdBlueLight,fontSize: 10.sp,fontWeight: FontWeight.bold),
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
            _selectedIndex = index;
          });
        },
        activeIndex: _selectedIndex,
      ),
    );
  }
}
