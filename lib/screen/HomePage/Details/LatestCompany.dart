import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrent/core/Color/color.dart';
import 'package:carrent/model/Company/CompanyModel.dart';
import 'package:carrent/provider/Company_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';



class LatestCompanyCard extends StatelessWidget {
  const LatestCompanyCard({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final company = Provider.of<CompanyProvider>(context, listen: true);
    var latestCompany = company.latestCompany;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 20).w,
        child: Row(
          children: [
            for(Company companyList in latestCompany)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10).w,
                    child: SizedBox(
                      height: 100.h,
                      width: 250.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15).w,
                        child: CachedNetworkImage(
                          imageUrl: companyList.imageCompany!.image.url,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${companyList.companyName} - ${companyList.carCount} Cars',style: TextStyle(fontSize: 12.sp,color: tdBlueLight,
                            fontWeight: FontWeight.bold),),
                      ],
                    ),
                  )

                ],
              )
          ],
        ),
      ),
    );
  }
}


