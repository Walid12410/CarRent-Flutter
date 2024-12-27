import "package:cached_network_image/cached_network_image.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/provider/Company_Provider.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:intl/intl.dart";
import "package:provider/provider.dart";

class CompanyMoreDetails extends StatefulWidget {
  const CompanyMoreDetails({super.key});

  @override
  State<CompanyMoreDetails> createState() => _CompanyMoreDetailsState();
}

class _CompanyMoreDetailsState extends State<CompanyMoreDetails> {
  @override
  Widget build(BuildContext context) {
    final company = Provider.of<CompanyProvider>(context, listen: true);
    var companyData = company.companyDetails;
    final defaultImage = companyData!.imageCompany!.isNotEmpty == true
        ? companyData.imageCompany!.firstWhere((image) => image.isDefaultImage,
            orElse: () => companyData.imageCompany!.first)
        : null;
    String formattedDate = DateFormat('MMM d, y').format(companyData.createdAt);

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20.w,
                      color: tdGrey,
                    )),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    height: 180.h,
                    child: defaultImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12).w,
                            child: CachedNetworkImage(
                              imageUrl: defaultImage.image.url,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: tdBlueLight,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          )
                        : Container(color: tdGrey, height: 180.h),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  companyData.companyName,
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: tdBlueLight,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  companyData.companyEmail,
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: tdBlueLight,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  companyData.companyPhoneNumber,
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: tdBlueLight,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Create at $formattedDate',
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: tdBlueLight,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Address: ${companyData.companyCountry} ${companyData.companyAddress} ${companyData.companyCity}',
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: tdBlueLight,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
