import "package:carrent/core/Time/CurrentTime.dart";
import "package:carrent/model/Review/ReviewModel.dart";
import "package:carrent/provider/Car_Provider.dart";
import "package:carrent/provider/Offer_Provider.dart";
import "package:carrent/provider/Review_Provider.dart";
import "package:carrent/provider/User_Provider.dart";
import "package:carrent/screen/CarDetailsPage/Details/CarDetailsImage.dart";
import "package:carrent/screen/CarDetailsPage/Details/CarDetailsView.dart";
import 'package:carrent/Widget/Review/ReviewCard.dart';
import "package:carrent/screen/CarDetailsPage/Details/UserReviewCard.dart";
import "package:flutter/material.dart";
import "package:carrent/core/Color/color.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:intl/intl.dart";
import "package:provider/provider.dart";
import "Details/CarHostView.dart";

class CarDetailsPage extends StatefulWidget {
  const CarDetailsPage({super.key, required this.carId});

  final String carId;

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    final car = Provider.of<CarProvider>(context, listen: false);
    final offer = Provider.of<OfferProvider>(context, listen: false);
    String currentTime = getCurrentTimeInISO();
    car.getCarDetails(widget.carId);
    offer.getCarOffer(currentTime, widget.carId);
  }

  @override
  Widget build(BuildContext context) {
    final car = Provider.of<CarProvider>(context, listen: true);
    final offer = Provider.of<OfferProvider>(context, listen: true);
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final reviewProvider = Provider.of<ReviewProvider>(context, listen: true);
    var carData = car.carDetails;
    var isOffer = offer.carOffer;
    var userReviews = reviewProvider.userReview;
    var user = userProvider.userDetails;

    if (carData == null || carData.id != widget.carId) {
      return const Center(
        child: CircularProgressIndicator(
          color: tdBlueLight,
        ),
      );
    }

    bool hasReview =
        userReviews.any((isReview) => isReview.carId == carData.id);
    Review? reviewUser;

    if (hasReview) {
      setState(() {
        reviewUser =
            userReviews.firstWhere((isReview) => isReview.carId == carData.id);
      });
    }

    void onDeleteReview() {
      setState(() {
        reviewUser = null;
      });
    }

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
              } else {
                return SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarImagePageView(
                          carImages: carData.carImage,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20).w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CarDetailView(carData: carData),
                              SizedBox(
                                height: 10.h,
                              ),
                              CarHostView(carData: carData),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'Review (${carData.reviewCount})',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: tdBlueLight,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              carData.review == null || carData.review!.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No reviews yet',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: tdGrey,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        if (hasReview &&
                                            reviewUser != null) ...[
                                          UserReviewCard(
                                              reviewUser: reviewUser,
                                              user: user,
                                              onDeleteReview: onDeleteReview),
                                        ],
                                        ListView.builder(
                                          shrinkWrap:
                                              true, // Allows the ListView to fit within the Column
                                          physics:
                                              const NeverScrollableScrollPhysics(), // Disable scrolling inside ListView
                                          itemCount: carData.review!.length,
                                          itemBuilder: (context, index) {
                                            final review =
                                                carData.review![index];
                                            DateTime parsedDate =
                                                DateTime.parse(review
                                                    .createdAt); // Parse the ISO date
                                            String formattedDate =
                                                DateFormat('MMM d, y')
                                                    .format(parsedDate);
                                            return ReviewCard(
                                              review: review,
                                              formattedDate: formattedDate,
                                            );
                                          },
                                        ),
                                        carData.reviewCount > 2
                                            ? TextButton(
                                                onPressed: () {
                                                  context.push(
                                                      '/CarReviewList/${carData.id}');
                                                },
                                                child: Text(
                                                  'See all reviews',
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: tdBlue,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                            : Container()
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ]),
                );
              }
            }),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: tdWhite,
        color: tdWhite,
        child: Padding(
          padding: const EdgeInsets.only(left: 15).w,
          child: Row(children: [
            SizedBox(
              width: 150.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${carData.carMake.carMakeName} ${carData.carModel} - ${carData.year}',
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: tdBlueLight,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (isOffer.isEmpty) ...[
                    Text(
                      '\$${carData.rentPrice} / day',
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: tdBlue,
                          fontWeight: FontWeight.bold),
                    )
                  ] else ...[
                    Row(
                      children: [
                        Text(
                          '\$${carData.rentPrice} / day',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: tdBlue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 3,
                            decorationColor: tdGrey,
                          ),
                        ),
                        Text(
                          '   \$${isOffer.first.discountPrice}/ day',
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ]
                ],
              ),
            ),
            SizedBox(
              width: 30.w,
            ),
            Expanded(
                child: GestureDetector(
              onTap: () {
                GoRouter.of(context).push(
                  '/payment',
                  extra: {
                    'car': carData,
                  },
                );
              },
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                    color: tdBlueLight,
                    borderRadius: BorderRadius.circular(15).w),
                child: Center(
                    child: Text(
                  'Rent car',
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: tdWhite,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ))
          ]),
        ),
      ),
    );
  }
}
