import 'package:cached_network_image/cached_network_image.dart';
import "package:carrent/core/Color/color.dart";
import "package:carrent/provider/Company_Provider.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:provider/provider.dart";

class CompanyDetailsPage extends StatefulWidget {
  const CompanyDetailsPage({super.key, required this.companyId});

  final String companyId;

  @override
  State<CompanyDetailsPage> createState() => _CompanyDetailsPageState();
}

class _CompanyDetailsPageState extends State<CompanyDetailsPage> {
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    final company = Provider.of<CompanyProvider>(context, listen: false);
    company.getCompanyDetails(widget.companyId);
  }

  @override
  Widget build(BuildContext context) {
    final company = Provider.of<CompanyProvider>(context, listen: true);
    var companyData = company.companyDetails;

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: FutureBuilder(
          future: _fetchDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: tdBlack,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Something went wrong, check your connection.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                    color: tdGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (companyData == null) {
              return Center(
                child: Text(
                  'Company data not available.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                    color: tdGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              // Check if imageCompany list exists and is not empty
              final defaultImage = companyData.imageCompany?.isNotEmpty == true
                  ? companyData.imageCompany!.firstWhere(
                      (image) => image.isDefaultImage,
                      orElse: () => companyData.imageCompany!.first)
                  : null;

              final secondImage = companyData.imageCompany?.isNotEmpty == true
                  ? companyData.imageCompany!.firstWhere(
                      (image) => !image.isDefaultImage,
                      orElse: () => companyData.imageCompany!.first)
                  : null;

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior:
                          Clip.none, // To allow profile image to overflow
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          height: 150.h, // Height of the cover image
                          child: secondImage != null
                              ? CachedNetworkImage(
                                  imageUrl: secondImage.image.url,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )
                              : Container(
                                  color: tdGrey,
                                  height: 150.h), // Placeholder if no image
                        ),
                        // Profile Image
                        Positioned(
                          bottom: -50.0
                              .w, // Push the image up from the bottom of the Stack
                          child: CircleAvatar(
                            radius: 50.0.w,
                            backgroundColor: tdWhite,
                            child: defaultImage != null
                                ? CachedNetworkImage(
                                    imageUrl: defaultImage.image.url,
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
                                : const Icon(
                                    Icons.error), // Placeholder if no image
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 45.h),
                    Column(
                        children: [
                          Text(
                            companyData.companyName,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: tdBlueLight,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            companyData.companyEmail,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: tdGrey,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.location_on_rounded,
                                      color: tdBlue,
                                      size: 40.w,
                                    ),
                                  ),
                                  Text(
                                    'Company Location',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: tdBlueLight,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.support_agent,
                                      color: tdBlue,
                                      size: 40.w,
                                    ),
                                  ),
                                  Text(
                                    'Support Service',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: tdBlueLight,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              // Third column for Company Details
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.assessment_rounded,
                                      color: tdBlue,
                                      size: 40.w,
                                    ),
                                  ),
                                  Text(
                                    'Company Details',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: tdBlueLight,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                      const Divider(color: tdGrey,thickness: 2,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20).w,
                      child: Column(
                        children: [
                           Text(
                            'Company cars (${companyData.carCount})',
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: tdBlueLight,
                                fontWeight: FontWeight.bold),
                          )
                      
                        ],
                      ),
                    )

                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
