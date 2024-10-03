import "package:carrent/Color/color.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";


class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions(
      {super.key,
      required this.discountAmount,
      required this.discountPercentage});

  final int discountAmount;
  final int discountPercentage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20).w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Terms and Conditions',
            style: TextStyle(
              fontSize: 15.sp,
              color: tdBlueLight,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.only(left: 20).w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- Minimum rent of \$$discountAmount',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: tdGrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '- Discount percent $discountPercentage%',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: tdGrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
