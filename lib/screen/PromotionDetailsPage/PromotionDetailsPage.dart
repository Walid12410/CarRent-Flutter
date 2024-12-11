import 'package:carrent/Api/PromoService.dart';
import 'package:carrent/Widget/Toast/ToastError.dart';
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
  bool isLoading = false;

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

  Future<void> _showMyDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20).w,
          ),
          backgroundColor: tdWhite,
          surfaceTintColor: tdWhite,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25).w,
                child: Text(
                  'Ready for a special deal? Get your promo code now!',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: tdBlueLight,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: isLoading
                        ? null
                        : () async {
                            PromoService service = PromoService();
                            final promo = Provider.of<PromoProvider>(context,
                                listen: false);
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              bool isPromoGet =
                                  await service.getPromo(widget.promoId);
                              if (isPromoGet) {
                                await promo.getUserPromo();
                                _fetchData();
                              }
                            } catch (e) {
                              showToast(
                                  'Something went wrong refresh the page');
                            } finally {
                              setState(() {
                                isLoading = false;
                                Navigator.of(context).pop();
                              });
                            }
                          },
                    child: Container(
                      width: 100.w,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: tdWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          isLoading ? 'Confirm...' : 'Get promo',
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: tdBlueLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 100.w,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: tdBlueLight,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: tdWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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
                        padding: const EdgeInsets.only(left: 20, right: 20).w,
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
                        promoId: promoData.id,
                        onGetPromo: () {
                          _showMyDialog();
                        },
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
