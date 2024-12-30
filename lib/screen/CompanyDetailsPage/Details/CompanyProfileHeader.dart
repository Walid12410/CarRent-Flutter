import "package:carrent/core/Color/color.dart";
import "package:carrent/model/Company/CompanyModel.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:carrent/core/UrlLuncher/UrlLuncherHelpe.dart";
import "package:go_router/go_router.dart";
import "package:url_launcher/url_launcher.dart";

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
                  onPressed: () async {
                    await URLLauncher.openMap(
                        companyData!.latitude, companyData!.longitude);
                  },
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
                  onPressed: () async {
                    try {
                      final Uri launchUri = Uri(
                        scheme: 'tel',
                        path: companyData!.companyPhoneNumber,
                      );
                      await launchUrl(launchUri);
                    } catch (e) {
                      throw Exception(e);
                    }
                  },
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
                  onPressed: () {
                    context.push('/companyMoreDetails');
                  },
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
