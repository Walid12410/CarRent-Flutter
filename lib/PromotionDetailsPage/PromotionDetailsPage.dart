import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrent/Color/color.dart';
import 'package:carrent/provider/Promo_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PromotionDetailsPage extends StatefulWidget {
  const PromotionDetailsPage({super.key, required this.promoId});

  final String promoId;

  @override
  State<PromotionDetailsPage> createState() => _PromotionDetailsPageState();
}

class _PromotionDetailsPageState extends State<PromotionDetailsPage> {
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    final promo = Provider.of<PromoProvider>(context, listen: false);
    await promo.getPromoDetails(widget.promoId);
  }

  @override
  Widget build(BuildContext context) {
    final promo = Provider.of<PromoProvider>(context, listen: true);
    var promoData = promo.promoDetails;


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
              } else if (promoData == null) {
                return Center(
                  child: Text(
                    'Something went wrong, try again later.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: tdGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(
                      width: double.infinity,
                      height: 200.h,
                      child: CachedNetworkImage(
                        imageUrl: (promoData.promoImage.url.isNotEmpty)
                            ? promoData.promoImage.url
                            : 'default_image_url',
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: tdBlueLight,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20).w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            promoData.promoTitle,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                              color: tdBlueLight,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.h),
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5).w,
                            child: Container(
                              width: double.infinity,
                              height: 60.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15).w,
                                border: Border.all(color: tdGrey),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 10)
                                    .w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'PROMO CODE',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: tdGrey,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          promoData.promoCode,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: tdBlueLight,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: double.infinity,
                                      width: 70.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15).w,
                                        color: tdBlueLight,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'COPY',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: tdWhite,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            promoData.promoDescription,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: tdGrey,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            'Terms and Conditions',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: tdBlueLight,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: const EdgeInsets.only(left: 20).w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '-Minimum rent of \$${promoData.discountAmount}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: tdGrey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '-Discount percent ${promoData.discountPercentage}%',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: tdGrey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '-Used for ${promoData.companyDetails?.companyName} company only',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: tdGrey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                );
              }
            }),
      ),
    );
  }
}
