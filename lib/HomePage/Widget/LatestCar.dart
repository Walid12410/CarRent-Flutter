import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Color/color.dart';
import '../../model/Car/CarModel.dart';
import '../../provider/Car_Provider.dart';

class LatestCarCard extends StatelessWidget {
  const LatestCarCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final car = Provider.of<CarProvider>(context, listen: true);
    var latestCar = car.latestCar;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 20).w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for(Car carList in latestCar)
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10).w,
                      child: SizedBox(
                        height: 110.h,
                        width: 200.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15).w,
                          child: CachedNetworkImage(
                            imageUrl: (carList.firstCarImage != null && carList.firstCarImage!.isNotEmpty)
                                ? carList.firstCarImage![0].carImage.url
                                : 'default_image_url',
                            fit: BoxFit.fill,
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
                    SizedBox(height: 5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 5).w,
                      child: Text('${carList.carType} ${carList.carModel} - ${carList.year}',style: TextStyle(fontSize: 12.sp,color: tdBlueLight,
                          fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 2.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.star_rounded,size: 20.w,color: Colors.yellow,),
                        Text('${carList.averageRating}',style: TextStyle(fontSize: 10.sp,color: tdBlueLight,fontWeight: FontWeight.bold),),
                        Text(' (${carList.reviewCount} review)',style: TextStyle(fontSize: 10.sp,color: tdGrey),)
                      ],
                    ),
                    SizedBox(height: 2.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 5).w,
                      child: Text('\$${carList.rentPrice} / day',style: TextStyle(fontSize: 12.sp,color: tdBlue,
                          fontWeight: FontWeight.bold),),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
