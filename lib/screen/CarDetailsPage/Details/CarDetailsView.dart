import "package:carrent/core/Color/color.dart";
import "package:carrent/model/CarDetails/CarDetailsModel.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";



class CarDetailView extends StatelessWidget {
  const CarDetailView({
    super.key,
    required this.carData,
  });

  final CarDetails carData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${carData.carMake} ${carData.carModel} - ${carData.year}',
          style: TextStyle(
              fontSize: 17.sp, color: tdBlueLight, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15.h,
        ),
        Text(
          'CAR DETAIL',
          style: TextStyle(
              fontSize: 12.sp, color: tdBlueLight, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fuel',
                  style: TextStyle(fontSize: 12.sp, color: tdGrey),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Interior Color',
                  style: TextStyle(fontSize: 12.sp, color: tdGrey),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Car type',
                  style: TextStyle(fontSize: 12.sp, color: tdGrey),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Kilometers',
                  style: TextStyle(fontSize: 12.sp, color: tdGrey),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Transmission',
                  style: TextStyle(fontSize: 12.sp, color: tdGrey),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  carData.fuelType,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: tdBlueLight,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  carData.color,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: tdBlueLight,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  carData.carType,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: tdBlueLight,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  '${carData.mileage}km',
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: tdBlueLight,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  carData.transmission,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: tdBlueLight,
                      fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}

