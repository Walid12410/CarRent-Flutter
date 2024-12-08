import "package:carrent/core/Color/color.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class RenterInfoLabel extends StatelessWidget {
  const RenterInfoLabel({super.key,required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          color: tdGrey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}