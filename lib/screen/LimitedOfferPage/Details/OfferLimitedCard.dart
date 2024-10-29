import "package:cached_network_image/cached_network_image.dart";
import "package:carrent/Widget/WatchDown/WatchCount.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/model/Offer/OfferModel.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";

class OfferLimitCard extends StatelessWidget {
  const OfferLimitCard({
    super.key,
    required this.offer,
    required this.parsedDate,
  });

  final Offer offer;
  final DateTime parsedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10).w,
      child: GestureDetector(
        onTap: () {
          GoRouter.of(context).pushNamed('CarDetails',
              pathParameters: {'id': offer.car!.id.toString()});
        },
        child: Container(
          decoration: BoxDecoration(
              color: tdWhite,
              borderRadius: BorderRadius.circular(15).w,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade600,
                    spreadRadius: 0.2,
                    blurRadius: 2)
              ]),
          child: Column(
            children: [
              SizedBox(
                height: 170.h,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(15).w,
                      topRight: const Radius.circular(15).w),
                  child: CachedNetworkImage(
                    imageUrl: (offer.car!.carImage.isNotEmpty)
                        ? offer.car!.carImage[0].carImage.url
                        : 'default_image_url',
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
                height: 2.h,
              ),
              Text(
                '${offer.car!.carMake.carMakeName} ${offer.car!.carModel} - ${offer.car!.year}',
                style: TextStyle(
                    fontSize: 15.sp,
                    color: tdBlueLight,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '\$${offer.car!.rentPrice} / day',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: tdBlueLight,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 3,
                      decorationColor: tdGrey,
                    ),
                  ),
                  Text(
                    '   \$${offer.discountPrice} / day',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                'Hurry up ends in:',
                style: TextStyle(
                    fontSize: 12.sp,
                    color: tdGrey,
                    fontWeight: FontWeight.bold),
              ),
              CountdownTimerScreen(endTime: parsedDate),
              SizedBox(
                height: 5.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
