import 'package:carrent/core/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOutBottom extends StatelessWidget {
  const LogOutBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        GoRouter.of(context).go('/onBoarding');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear(); // This will clear all stored data in SharedPreferences
      },
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: tdBlueLight,
          borderRadius: BorderRadius.circular(10).w,
        ),
        child: Center(
          child: Text(
            'Logout',
            style: TextStyle(
              fontSize: 12.sp,
              color: tdWhite,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
