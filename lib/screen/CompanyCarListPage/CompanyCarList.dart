import 'package:carrent/Widget/Car/CarCard.dart';
import "package:carrent/core/Color/color.dart";
import "package:carrent/provider/Car_Provider.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

class CompanyCarList extends StatefulWidget {
  const CompanyCarList({super.key, required this.companyId});

  final String companyId;

  @override
  State<CompanyCarList> createState() => _CompanyCarListState();
}

class _CompanyCarListState extends State<CompanyCarList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CarProvider>(context, listen: false)
          .fetchCars(widget.companyId);
    });
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 200) {
      Provider.of<CarProvider>(context, listen: false)
          .fetchCars(widget.companyId);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    Provider.of<CarProvider>(context, listen: false).resetCompanyCar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      appBar: AppBar(
        title: Text(
          'Company Cars',
          style: TextStyle(
            fontSize: 15.sp,
            color: tdBlueLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: tdWhite,
        shadowColor: tdWhite,
        surfaceTintColor: tdWhite,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20).w,
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20.w,
              color: tdGrey,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20).w,
            child: IconButton(
              icon: Icon(
                Icons.search,
                size: 20.w,
                color: tdGrey,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Consumer<CarProvider>(builder: (context, carProvider, child) {
        if (carProvider.isLoading && carProvider.cars.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              color: tdBlueLight,
            ),
          );
        }

        if (carProvider.cars.isEmpty) {
          return Center(
            child: Text(
              'No car added yet for this company',
              style: TextStyle(
                  fontSize: 15.sp,
                  color: tdBlueLight,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        }

        return ListView.builder(
            controller: _scrollController,
            itemCount:
                carProvider.cars.length + (carProvider.hasMoreData ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == carProvider.cars.length) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: tdBlueLight,
                  ),
                );
              }
              final car = carProvider.cars[index];
              return CarCard(car: car);
            });
      }),
    );
  }
}
