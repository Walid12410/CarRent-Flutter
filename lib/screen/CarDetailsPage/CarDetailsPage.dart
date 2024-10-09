import "package:cached_network_image/cached_network_image.dart";
import "package:carrent/model/CarDetails/CarDetailsModel.dart";
import "package:carrent/provider/Car_Provider.dart";
import "package:carrent/screen/CarDetailsPage/Details/CarDetailsImage.dart";
import "package:carrent/screen/CarDetailsPage/Details/CarDetailsView.dart";
import "package:flutter/material.dart";
import "package:carrent/core/Color/color.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:provider/provider.dart";

import "Details/CarHostView.dart";

class CarDetailsPage extends StatefulWidget {
  const CarDetailsPage({super.key, required this.carId});

  final String carId;

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      final car = Provider.of<CarProvider>(context, listen: false);
      car.getCarDetails(widget.carId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final car = Provider.of<CarProvider>(context, listen: true);
    var carData = car.carDetails;
    if (carData == null) {
      return const Center(
          child: CircularProgressIndicator(
        color: tdBlack,
      ));
    }
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      SizedBox(height: 10.h,),
                      Text('Review (40)',style: TextStyle(fontSize: 12.sp,color: tdBlueLight,fontWeight: FontWeight.w500),)
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

