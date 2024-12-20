import "package:carrent/core/Color/color.dart";
import "package:carrent/model/Company/CompanyModel.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";



class CompanyProfileHeader extends StatelessWidget {
  const CompanyProfileHeader({
    super.key,
    required this.companyData,
  });

  final Company? companyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          companyData!.companyName,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: tdBlueLight,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          companyData!.companyEmail,
          style: TextStyle(
            fontSize: 10.sp,
            color: tdGrey,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.location_on_rounded,
                    color: tdBlue,
                    size: 40.w,
                  ),
                ),
                Text(
                  'Company Location',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: tdBlueLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.support_agent,
                    color: tdBlue,
                    size: 40.w,
                  ),
                ),
                Text(
                  'Support Service',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: tdBlueLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.assessment_rounded,
                    color: tdBlue,
                    size: 40.w,
                  ),
                ),
                Text(
                  'Company Details',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: tdBlueLight,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}

