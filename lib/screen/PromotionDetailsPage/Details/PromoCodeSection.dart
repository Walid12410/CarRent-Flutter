import 'package:carrent/core/Color/color.dart';
import "package:carrent/provider/Promo_Provider.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:provider/provider.dart";

class PromoCodeSection extends StatelessWidget {
  const PromoCodeSection({
    super.key,
    required this.promoCode,
    required this.onCopy,
    required this.promoId,
    required this.onGetPromo,
  });

  final String promoCode;
  final VoidCallback onCopy;
  final VoidCallback onGetPromo;
  final String promoId;

  @override
  Widget build(BuildContext context) {
    final promoProvider = Provider.of<PromoProvider>(context, listen: true);
    final userPromo = promoProvider.userPromo;

    bool hasPromo = userPromo.any((promo) => promo.promoId == promoId);
    bool hasUsedPromo = false;

    if (hasPromo) {
      final promo = userPromo.firstWhere((promo) => promo.promoId == promoId);
      hasUsedPromo = promo.isUsed;
    }

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
              if (!hasPromo || hasUsedPromo)
                Expanded(
                  child: Center(
                    child: Text(
                      hasUsedPromo ? 'PROMO ALREADY USED' : 'Hidden code',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: hasUsedPromo ? Colors.red : tdGrey,
                        fontWeight: hasUsedPromo ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                )
              else
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
              hasPromo
                  ? hasUsedPromo
                      ? Container() // No action available for already used promo
                      : GestureDetector(
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
                        )
                  : GestureDetector(
                      onTap: onGetPromo,
                      child: Container(
                        height: double.infinity,
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15).w,
                          color: Colors.green,
                        ),
                        child: Center(
                          child: Text(
                            'GET PROMO',
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
