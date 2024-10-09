import "package:cached_network_image/cached_network_image.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/model/CarDetails/CarDetailsModel.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";


class CarHostView extends StatelessWidget {
  const CarHostView({
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
          'HOST DETAIL',
          style: TextStyle(
              fontSize: 12.sp, color: tdBlueLight, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 35.h,
              width: 40.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12).w,
                child: Builder(
                  builder: (context) {
                    final defaultImage = carData.company!.imageCompany
                        ?.firstWhere((image) => image.isDefaultImage);
                    if (defaultImage == null) {
                      return const Icon(Icons.error);
                    }
                    return CachedNetworkImage(
                      imageUrl: defaultImage.image.url,
                      fit: BoxFit.fill,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: tdBlueLight,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    );
                  },
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
                Text(
                  carData.company!.companyName,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: tdBlueLight,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  carData.company!.companyEmail,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: tdGrey,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  // nav to company details
                },
                icon: Icon(
                  Icons.arrow_outward_outlined,
                  size: 20.w,
                  color: tdGrey,
                ))
          ],
        ),
      ],
    );
  }
}

