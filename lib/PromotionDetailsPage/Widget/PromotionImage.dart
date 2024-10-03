import "package:cached_network_image/cached_network_image.dart";
import "package:carrent/Color/color.dart";
import "package:carrent/model/Promo/PromoDetailsModel.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";


class PromotionImage extends StatelessWidget {
  const PromotionImage({super.key, required this.promoData});

  final PromoDetails promoData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200.h,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: (promoData.promoImage.url.isNotEmpty)
                ? promoData.promoImage.url
                : 'default_image_url',
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(
              value: downloadProgress.progress,
              color: tdBlueLight,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            width: double.infinity,
            height: 200.h,
          ),
          Positioned(
            top: 15.0.h,
            left: 15.0.w,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20.w,
              ),
              color: tdWhite, // Icon color
              onPressed: () {
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
