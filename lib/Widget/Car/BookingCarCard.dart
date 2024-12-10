import "package:cached_network_image/cached_network_image.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/model/Booking/BookingModel.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:intl/intl.dart";

class BookingCarCard extends StatelessWidget {
  const BookingCarCard({
    super.key,
    required this.book,
  });

  final Booking book;

  @override
  Widget build(BuildContext context) {
    String startDate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(book.startDate));
    String endDate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(book.endDate));

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80.h,
            width: 100.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12).w,
              child: CachedNetworkImage(
                imageUrl: book.car!.carImage[0].carImage.url,
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
          SizedBox(
            width: 10.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Text(
                '${book.car!.carMake.carMakeName} ${book.car!.carModel} - ${book.car!.year}',
                style: TextStyle(
                    fontSize: 15.sp,
                    color: tdBlueLight,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Total price rented: \$${book.totalRentPrice.toStringAsFixed(0)} / day',
                style: TextStyle(
                    fontSize: 12.sp,
                    color: tdBlueLight,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'From $startDate to $endDate',
                style: TextStyle(
                    fontSize: 10.sp,
                    color: tdBlueLight,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                'Days rented : ${book.daysRent}',
                style: TextStyle(
                    fontSize: 10.sp,
                    color: tdBlueLight,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }
}
