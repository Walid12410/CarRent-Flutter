import 'package:carrent/Widget/Car/CarCard.dart';
import "package:carrent/core/Color/color.dart";
import "package:carrent/model/Car/CarModel.dart";
import "package:carrent/provider/Car_Provider.dart";
import "package:carrent/provider/Company_Provider.dart";
import "package:carrent/screen/CompanyDetailsPage/Details/CompanyImages.dart";
import "package:carrent/screen/CompanyDetailsPage/Details/CompanyProfileHeader.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
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
    final car = Provider.of<CarProvider>(context, listen: false);
    await car.getLatestCompanyCar(widget.companyId, 1);
    await company.getCompanyDetails(widget.companyId);
  }

  @override
  Widget build(BuildContext context) {
    final company = Provider.of<CompanyProvider>(context, listen: true);
    final car = Provider.of<CarProvider>(context, listen: true);
    var companyData = company.companyDetails;
    var latestCars = car.latestCompanyCar;

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
                    CompanyImageStack(
                        secondImage: secondImage, defaultImage: defaultImage),
                    SizedBox(height: 45.h),
                    CompanyProfileHeader(companyData: companyData),
                    const Divider(
                      color: tdGrey,
                      thickness: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20).w,
                      child: Text(
                        'Company cars (${companyData.carCount})',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: tdBlueLight,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    latestCars.isNotEmpty
                        ? Column(
                            children: [
                              for (Car car in latestCars) CarCard(car: car),
                              companyData.carCount > 5
                                  ? Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          GoRouter.of(context).pushNamed(
                                              'CompanyCarDetails',
                                              pathParameters: {
                                                "id": companyData.id
                                              });
                                        },
                                        child: Container(
                                          height: 35.h,
                                          width: 150.w,
                                          decoration: BoxDecoration(
                                              color: tdBlueLight,
                                              borderRadius:
                                                  BorderRadius.circular(10).w),
                                          child: Center(
                                              child: Text(
                                            'Show more',
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                color: tdWhite),
                                          )),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                height: 15.h,
                              )
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 40.h,
                              ),
                              Center(
                                child: Text(
                                  'No car added yet for this company',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: tdBlueLight,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
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
