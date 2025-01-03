import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrent/core/Color/color.dart';
import 'package:carrent/model/Car/CarModel.dart';
import 'package:carrent/provider/Booking_Provider.dart';
import 'package:carrent/provider/Review_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CarCategoryCard extends StatelessWidget {
  const CarCategoryCard({
    super.key,
    required this.car,
  });

  final Car car;

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    final allUserBooking = bookingProvider.allUserBooking;
    final review = Provider.of<ReviewProvider>(context, listen: false);
    var userReview = review.userReview;

    // check if user already review this car
    bool hasReview = userReview.any((review) => review.carId == car.id);

    // Check if the user has booked this car
    bool hasBooked = allUserBooking.any((booking) => booking.carId == car.id);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.h),
        GestureDetector(
          onTap: (){
            GoRouter.of(context).pushNamed('CarDetails',
              pathParameters: {'id': car.id.toString()});
          },
          child: SizedBox(
            height: 150.h,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15).w,
              child: CachedNetworkImage(
                imageUrl: (car.carImage.isNotEmpty)
                    ? car.carImage[0].carImage.url
                    : 'https://www.its.ac.id/tmesin/wp-content/uploads/sites/22/2022/07/no-image.png',
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: tdBlueLight,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          '${car.carMake.carMakeName} ${car.carModel} - ${car.year}',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15.sp, color: tdBlueLight),
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
                    car.averageRating.toStringAsFixed(1),
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: tdBlueLight,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' (${car.reviewCount} review)',
                    style: TextStyle(fontSize: 10.sp, color: tdGrey),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        hasBooked
            ? Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        hasReview ? context.push('/updateReview', extra: car) :
                        context.push('/addReview', extra: car);
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
            GoRouter.of(context).pushNamed('CarDetails',
              pathParameters: {'id': car.id.toString()});
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
                            'Explore Car Info',
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
              )
            : GestureDetector(
                onTap: () {
            GoRouter.of(context).pushNamed('CarDetails',
              pathParameters: {'id': car.id.toString()});
                },
                child: Container(
                  height: 40.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: tdBlueLight,
                    borderRadius: BorderRadius.circular(15).w,
                  ),
                  child: Center(
                    child: Text(
                      'Explore Car Info',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: tdWhite,
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
