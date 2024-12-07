import 'package:carrent/core/Color/color.dart';
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions(
      {super.key,
      required this.discountPercentage,
      required this.companyId,
      required this.companyName});

  final int discountPercentage;
  final String companyName;
  final String companyId;

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
                  '- Used one times',
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
                Row(
                  children: [
                    Text(
                      '- Valid for ',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: tdGrey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).pushNamed(
                          'companydetils',
                          pathParameters: {'id': companyId.toString()},
                        );
                      },
                      child: Text(
                        companyName,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: tdBlueLight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      ' cars only',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: tdGrey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
