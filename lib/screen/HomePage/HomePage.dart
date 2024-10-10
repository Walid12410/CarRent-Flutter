import 'package:carrent/core/Color/color.dart';
import 'package:carrent/core/Time/CurrentTime.dart';
import 'package:carrent/model/Promo/PromoModel.dart';
import 'package:carrent/provider/Car_Provider.dart';
import 'package:carrent/provider/Company_Provider.dart';
import 'package:carrent/provider/Offer_Provider.dart';
import 'package:carrent/provider/Promo_Provider.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'Details/HeaderPage.dart';
import 'Details/LatestCar.dart';
import 'Details/LatestCompany.dart';
import 'Details/LatestPromo.dart';
import 'Details/SectionTitle.dart';
import 'Details/TopOffer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    String currentTime = getCurrentTimeInISO();
    final promo = Provider.of<PromoProvider>(context, listen: false);
    final car = Provider.of<CarProvider>(context, listen: false);
    final company = Provider.of<CompanyProvider>(context, listen: false);
    final offer = Provider.of<OfferProvider>(context, listen: false);
    await offer.getTopOffer(currentTime);
    await car.getLatestCar();
    await promo.getLatestPromo(1 , currentTime , 3);
    await company.getLastCompany();
  }

  @override
  Widget build(BuildContext context) {
    final promo = Provider.of<PromoProvider>(context, listen: true);
    var latestPromo = promo.latestPromo;

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _fetchData,
            color: tdBlueLight,
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
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          const HeaderPage(),
                          SizedBox(
                            height: 10.h,
                          ),
                          Column(
                            children: [
                              latestPromo.isNotEmpty? ExpandablePageView(
                                  controller: _pageController,
                                  onPageChanged: (page) {
                                    setState(() {
                                      _currentPage = page;
                                    });
                                  },
                                  children: [
                                    for (Promo promoList in latestPromo)
                                      PromoCard(promoList: promoList),
                                  ]) : Padding(
                                    padding: const EdgeInsets.only(left: 20,right: 20).w,
                                    child: Container(
                                      width: double.infinity,
                                      height: 170.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: tdGrey),
                                        borderRadius: BorderRadius.circular(15).w,
                                        color: tdWhite
                                      ),
                                      child: Center(
                                        child: Text('No promo added yet',style: TextStyle(fontSize: 12.sp,color: tdBlueLight,fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                  ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20).w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: List.generate(
                                    3,
                                    (index) => Container(
                                      width: index == _currentPage ? 8.w : 5.w,
                                      height: index == _currentPage ? 8.h : 5.h,
                                      margin: EdgeInsets.symmetric(horizontal: 6.w),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: index == _currentPage
                                            ? tdBlueLight
                                            : tdGrey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.h,),
                              const SectionTitle(title: 'Latest Vehicle', actionText: 'See more'),
                              SizedBox(height: 10.h),
                              const LatestCarCard(),
                              SizedBox(height: 15.h),
                              const SectionTitle(title: 'Our Partners', actionText: 'See all'),
                              SizedBox(height: 10.h),
                              const LatestCompanyCard(),
                              SizedBox(height: 15.h),
                              const SectionTitle(title: 'Limited Offer', actionText: 'See more'),
                              SizedBox(height: 10.h),
                              const TopOfferCard(),
                              SizedBox(height: 50.h,),
                            ],
                          )
                        ],
                      ),
                    );
                  }
                }),
          ),
      ),
    );
  }
}






