import "package:cached_network_image/cached_network_image.dart";
import 'package:carrent/core/Color/color.dart';
import "package:carrent/model/Feature/FeatureModel.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";


class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.feature,
  });

  final Feature feature;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20,top: 5).w,
      child: GestureDetector(
        onTap: (){
          //
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: 150.h,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15).w,
                  child: CachedNetworkImage(
                    imageUrl: (feature.car?.carImage != null &&
                            feature.car!.carImage.isNotEmpty)
                        ? feature.car!.carImage[0].carImage.url
                        : 'https://www.its.ac.id/tmesin/wp-content/uploads/sites/22/2022/07/no-image.png',
                    fit: BoxFit.fill,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: tdBlueLight,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                '${feature.car!.carMake} ${feature.car!.carModel} - ${feature.car!.year}',
                style: TextStyle(
                    fontSize: 15.sp,
                    color: tdBlueLight,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 20.w,
                    color: Colors.yellow,
                  ),
                  Text(
                    '${feature.car!.averageRating}',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: tdBlueLight,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' (${feature.car!.reviewCount} review)',
                    style: TextStyle(fontSize: 12.sp, color: tdGrey),
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                ' \$${feature.car!.rentPrice} / day',
                style: TextStyle(
                    fontSize: 12.sp,
                    color: tdBlueLight,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15.h,
              ),
            ]),
      ),
    );
  }
}
