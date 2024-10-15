import "package:cached_network_image/cached_network_image.dart";
import 'package:carrent/core/Color/color.dart';
import "package:carrent/model/Car/CarModel.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";

class CarCard extends StatelessWidget {
  const CarCard({
    super.key,
    required this.car,
  });

  final Car car;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5).w,
      child: GestureDetector(
        onTap: () {
          GoRouter.of(context).pushNamed('CarDetails',
              pathParameters: {'id': car.id.toString()});
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
                    imageUrl: (car.carImage.isNotEmpty)
                        ? car.carImage[0].carImage.url
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
                '${car.carMake} ${car.carModel} - ${car.year}',
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
                    '${car.averageRating}',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: tdBlueLight,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' (${car.reviewCount} review)',
                    style: TextStyle(fontSize: 12.sp, color: tdGrey),
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                ' \$${car.rentPrice} / day',
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
