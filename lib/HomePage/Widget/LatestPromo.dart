import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../Color/color.dart';
import '../../model/Promo/PromoModel.dart';


class PromoCard extends StatelessWidget {
  const PromoCard({
    super.key,
    required this.promoList,
  });

  final Promo promoList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20).w,
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              GoRouter.of(context).pushNamed('PromoDetails',pathParameters: {
                'id' : promoList.id.toString()
              });
            },
            child: SizedBox(
              height: 170.h,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15).w,
                child: CachedNetworkImage(
                  imageUrl: promoList.promoImage.url,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder:
                      (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress, color: tdBlueLight,),
                  errorWidget:
                      (context, url, error) =>
                  const Icon(Icons.error),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(promoList.promoTitle,
            style: TextStyle(
                fontSize: 15.sp,
                color: tdBlueLight,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
