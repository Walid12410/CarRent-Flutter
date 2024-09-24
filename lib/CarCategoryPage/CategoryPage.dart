import 'package:carrent/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarCategoryPage extends StatefulWidget {
  const CarCategoryPage({super.key});

  @override
  State<CarCategoryPage> createState() => _CarCategoryPageState();
}

class _CarCategoryPageState extends State<CarCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20).w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20.w,
                      color: tdGrey,
                    )),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Category',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: tdBlueLight),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
