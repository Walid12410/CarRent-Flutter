import 'package:carrent/core/Color/color.dart';
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";



class PromoCodeSection extends StatelessWidget {
  const PromoCodeSection(
      {super.key, required this.promoCode, required this.onCopy});

  final String promoCode;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).w,
      child: Container(
        width: double.infinity,
        height: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15).w,
          border: Border.all(color: tdGrey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10).w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PROMO CODE',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: tdGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    promoCode,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: tdBlueLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onCopy,
                child: Container(
                  height: double.infinity,
                  width: 70.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15).w,
                    color: tdBlueLight,
                  ),
                  child: Center(
                    child: Text(
                      'COPY',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: tdWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

