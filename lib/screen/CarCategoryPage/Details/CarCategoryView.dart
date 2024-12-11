import 'package:carrent/core/Color/color.dart';
import 'package:carrent/model/Car/CarModel.dart';
import 'package:carrent/provider/Booking_Provider.dart';
import 'package:carrent/provider/Car_Provider.dart';
import 'package:carrent/Widget/Car/CarCategoryCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CarCategoryView extends StatefulWidget {
  const CarCategoryView({super.key, required this.categoryId});

  final String categoryId;

  @override
  State<CarCategoryView> createState() => _CarCategoryViewState();
}

class _CarCategoryViewState extends State<CarCategoryView> {
  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  @override
  void didUpdateWidget(CarCategoryView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryId != widget.categoryId) {
      _fetchDataFuture = _fetchData();
    }
  }

  Future<void> _fetchData() async {
    final car = Provider.of<CarProvider>(context, listen: false);
    car.getCategoryCar(1, widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    final car = Provider.of<CarProvider>(context, listen: true);
    var categoryCar = car.categoryCar;

    return FutureBuilder(
      future: _fetchDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.h,),
              const Center(
                child: CircularProgressIndicator(
                  color: tdBlack,
                ),
              ),
            ],
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
        }else if(categoryCar.isEmpty){
          return Column(
            mainAxisAlignment : MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height : 100.h),
              Text('No car for this category', style: TextStyle(
                fontSize: 15.sp,color: tdGrey , fontWeight: FontWeight.bold
              ),textAlign: TextAlign.center,)
            ],
          );
        } else {
          return SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20).w,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                for (Car car in categoryCar)
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5).w,
                    child: CarCategoryCard(car: car),
                  ),
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pushNamed('CarCategoryList',pathParameters: {'id': widget.categoryId});
                    },
                    child: Container(
                      height: 35.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          color: tdBlueLight,
                          borderRadius: BorderRadius.circular(10).w),
                      child: Center(
                          child: Text(
                        'Show more',
                        style: TextStyle(fontSize: 12.sp, color: tdWhite),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          ));
        }
      },
    );
  }
}
