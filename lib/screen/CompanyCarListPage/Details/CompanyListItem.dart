import "package:cached_network_image/cached_network_image.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/model/Company/CompanyModel.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";


class CompanyListItem extends StatelessWidget {
  final Company company;

  const CompanyListItem({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              GoRouter.of(context).pushNamed('CompanyDetails',
                  pathParameters: {'id': company.id.toString()});
            },
            child: SizedBox(
              height: 150.h,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15).w,
                child: Builder(
                  builder: (context) {
                    if (company.imageCompany == null ||
                        company.imageCompany!.isEmpty) {
                      return const Icon(Icons.error);
                    }
                    final defaultImage = company.imageCompany
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
          ),
          Text(
            '${company.companyName} - ${company.carCount} cars',
            style: TextStyle(
                fontSize: 15.sp,
                color: tdBlueLight,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

