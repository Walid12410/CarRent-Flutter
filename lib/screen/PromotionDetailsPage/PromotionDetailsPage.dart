import 'package:carrent/core/Color/color.dart';
import 'package:carrent/provider/Promo_Provider.dart';
import 'package:carrent/screen/PromotionDetailsPage/Details/PromoCodeSection.dart';
import 'package:carrent/screen/PromotionDetailsPage/Details/PromoDescription.dart';
import 'package:carrent/screen/PromotionDetailsPage/Details/PromoTerms.dart';
import 'package:carrent/screen/PromotionDetailsPage/Details/PromotionImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Promo code copied',
          style: TextStyle(fontSize: 10.sp, color: tdWhite),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: tdBlueLight,
      ),
    );
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PromotionImage(promoData: promoData),
                      SizedBox(height: 15.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20).w,
                        child: Text(
                          promoData.promoTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            color: tdBlueLight,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      PromoCodeSection(
                        promoCode: promoData.promoCode,
                        onCopy: () => copyToClipboard(promoData.promoCode),
                      ),
                      SizedBox(height: 20.h),
                      PromotionDescription(
                          description: promoData.promoDescription),
                      SizedBox(height: 20.h),
                      TermsAndConditions(
                        discountPercentage: promoData.discountPercentage,
                        companyId: promoData.company!.id,
                        companyName: promoData.company!.companyName,
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}

