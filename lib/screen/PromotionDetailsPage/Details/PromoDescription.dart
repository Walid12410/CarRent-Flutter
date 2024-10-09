import 'package:carrent/core/Color/color.dart';
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";


class PromotionDescription extends StatelessWidget {
  const PromotionDescription({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).w,
      child: Text(
        description,
        style: TextStyle(
          fontSize: 12.sp,
          color: tdGrey,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

