import "package:cached_network_image/cached_network_image.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/model/Company/ImageCompanyModel.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";


class CompanyImageStack extends StatelessWidget {
  const CompanyImageStack({
    super.key,
    required this.secondImage,
    required this.defaultImage,
  });

  final ImageCompany? secondImage;
  final ImageCompany? defaultImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: 150.h,
          child: secondImage != null
              ? CachedNetworkImage(
                  imageUrl: secondImage!.image.url,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: tdBlueLight,
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                )
              : Container(color: tdGrey, height: 150.h),
        ),
          Positioned(
            top: 15.0.h,
            left: 15.0.w,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20.w,
              ),
              color: tdWhite, // Icon color
              onPressed: () {
                context.pop();
              },
            ),
          ),
        Positioned(
          bottom: -50.0.w,
          child: CircleAvatar(
            radius: 50.0.w,
            backgroundColor: tdWhite,
            child: defaultImage != null
                ? CachedNetworkImage(
                    imageUrl: defaultImage!.image.url,
                    imageBuilder: (context, imageProvider) =>
                        Container(
                      width: 120.w,
                      height: 200.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: tdWhite, width: 2.w),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : const Icon(Icons.error),
          ),
        ),
      ],
    );
  }
}

