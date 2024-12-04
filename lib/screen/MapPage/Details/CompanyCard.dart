import "package:cached_network_image/cached_network_image.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/core/UrlLuncher/UrlLuncherHelpe.dart";
import "package:carrent/model/Company/CompanyModel.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";

class CompanyCard extends StatelessWidget {
  const CompanyCard({
    super.key,
    required Company? selectedCompany,
  }) : _selectedCompany = selectedCompany;

  final Company? _selectedCompany;

  @override
  Widget build(BuildContext context) {
    final defaultImage = _selectedCompany?.imageCompany?.isNotEmpty == true
        ? _selectedCompany?.imageCompany!.firstWhere(
            (image) => image.isDefaultImage,
            orElse: () => _selectedCompany.imageCompany!.first)
        : null;

    return Container(
        padding: const EdgeInsets.all(10).w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12).w,
          color: tdWhite,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 100.w,
              height: 80.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12).w,
                child: defaultImage != null
                    ? CachedNetworkImage(
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
                      )
                    : const Icon(Icons.error),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            SizedBox(
              width: 180.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${_selectedCompany?.companyName}',
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: tdBlueLight,
                          fontWeight: FontWeight.bold)),
                  Text(
                    '${_selectedCompany?.companyEmail}',
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: tdBlueLight,
                        fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await URLLauncher.openMap(_selectedCompany!.latitude,
                              _selectedCompany!.longitude);
                        },
                        child: Icon(
                          Icons.assistant_direction,
                          color: tdGrey,
                          size: 20.w,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await URLLauncher.openMap(_selectedCompany!.latitude,
                              _selectedCompany!.longitude);
                        },
                        child: Text(
                          ' Direct location',
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: tdBlueLight,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).pushNamed(
                            'companydetils',
                            pathParameters: {
                              'id': _selectedCompany!.id.toString()
                            },
                          );
                        },
                        child: Icon(
                          Icons.arrow_outward_outlined,
                          color: tdGrey,
                          size: 20.w,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).pushNamed(
                            'companydetils',
                            pathParameters: {
                              'id': _selectedCompany!.id.toString()
                            },
                          );
                        },
                        child: Text(
                          ' More',
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: tdBlueLight,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
