import "package:carrent/provider/Car_Provider.dart";
import "package:carrent/screen/CarDetailsPage/Details/CarDetailsImage.dart";
import "package:carrent/screen/CarDetailsPage/Details/CarDetailsView.dart";
import "package:carrent/screen/CarDetailsPage/Details/ReviewCard.dart";
import "package:flutter/material.dart";
import "package:carrent/core/Color/color.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
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
    car.getCarDetails(widget.carId);
  }

  @override
  Widget build(BuildContext context) {
    final car = Provider.of<CarProvider>(context, listen: true);
    var carData = car.carDetails;
    
    if (carData == null || carData.id != widget.carId) {
      return const Center(
        child: CircularProgressIndicator(
          color: tdBlueLight,
        ),
      );
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
              }else {
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
                                        TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              'See more review',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: tdBlue,
                                                  fontWeight: FontWeight.bold),
                                            ))
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
          padding: const EdgeInsets.only(left: 20).w,
          child: Row(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${carData.carMake} ${carData.carModel} - ${carData.year}',style: TextStyle(
                  fontSize: 15.sp,color: tdBlueLight,fontWeight: FontWeight.bold
                ),),
                Text('\$${carData.rentPrice} / day',style: TextStyle(
                  fontSize: 15.sp,color: tdBlue,fontWeight: FontWeight.bold
                ),)

              ],
            ),
            SizedBox(width: 30.w,),
            Expanded(child: GestureDetector(
              onTap: (){
                // rent car page
              },
              child: Container(
                height: 50.h,
                decoration:  BoxDecoration(
                  color: tdBlueLight,
                  borderRadius: BorderRadius.circular(15).w
                ),
                child: Center(child: Text('Rent car',style:
                 TextStyle(fontSize: 15.sp,color: tdWhite,fontWeight: FontWeight.bold),)),
              ),
            ))
          ]),
        ),
      ),
    );
  }
}

