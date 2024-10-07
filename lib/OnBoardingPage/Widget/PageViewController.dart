import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Color/color.dart';

class PageViewContainer extends StatelessWidget {
  const PageViewContainer({
    super.key,
    required this.imagePath,
    required this.title,
    required this.desc,
  });

  final String imagePath;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250.h,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15).w,
              child: Image.asset(
                imagePath,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 40.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              color: tdBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            desc,
            style: TextStyle(fontSize: 15.sp, color: tdGrey),
          ),
        ],
      ),
    );
  }
}
