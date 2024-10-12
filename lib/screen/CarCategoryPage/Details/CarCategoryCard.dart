import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrent/core/Color/color.dart';
import 'package:carrent/model/Car/CarModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarCategoryCard extends StatelessWidget {
  const CarCategoryCard({
    super.key,
    required this.car,
  });

  final Car car;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.h),
        SizedBox(
          height: 150.h,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15).w,
            child: CachedNetworkImage(
              imageUrl: (car.carImage != Null &&
                      car.carImage.isNotEmpty)
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
        SizedBox(height: 5.h),
        Text(
          '${car.carMake} ${car.carModel} - ${car.year}',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
              color: tdBlueLight),
        ),
        SizedBox(height: 5.h),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5).w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${car.rentPrice} / day',
                style: TextStyle(
                    fontSize: 12.sp,
                    color: tdBlueLight,
                    fontWeight: FontWeight.bold),
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
                        fontSize: 10.sp,
                        color: tdBlueLight,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' (${car.reviewCount} review)',
                    style: TextStyle(
                        fontSize: 10.sp, color: tdGrey),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Write review action
                },
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: tdBlueLight,
                    borderRadius: BorderRadius.circular(15).w,
                  ),
                  child: Center(
                    child: Text(
                      'Write review',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: tdWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 5.w),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Booking car action
                },
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: tdWhite,
                    border: Border.all(color: tdGrey),
                    borderRadius: BorderRadius.circular(15).w,
                  ),
                  child: Center(
                    child: Text(
                      'Booking car',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: tdGrey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
