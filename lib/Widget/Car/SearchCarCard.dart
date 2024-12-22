import "package:cached_network_image/cached_network_image.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/model/Car/CarModel.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";

class SearchCarCard extends StatelessWidget {
  const SearchCarCard({
    super.key,
    required this.car,
  });

  final Car car;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        GoRouter.of(context).pushNamed('CarDetails',
          pathParameters: {'id': car.id.toString()});

      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5,bottom: 5).w,
        child: Column(
          children: [
            Row(
                children: [
                      SizedBox(
                        height: 50.h,
                        width: 65.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12).w,
                          child: CachedNetworkImage(
                            imageUrl: car.carImage[0].carImage.url,
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
                      SizedBox(width: 10.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${car.carModel} - ${car.year}',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: tdBlueLight,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "${car.rentPrice.toString()}\$ / day",
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: tdBlueLight,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h,)
          ],
        ),
        
      ),
    );
  }
}

