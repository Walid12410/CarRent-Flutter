import "package:carrent/Widget/Car/CarCard.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/provider/Car_Provider.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";


class LatestCarPage extends StatefulWidget {
  const LatestCarPage({super.key});

  @override
  State<LatestCarPage> createState() => _LatestCarPageState();
}

class _LatestCarPageState extends State<LatestCarPage> {
  late ScrollController _scrollController;
  late CarProvider carsProvider;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      carsProvider.fetchLatestCars();
    });
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 200) {
      Provider.of<CarProvider>(context, listen: false)
          .fetchLatestCars();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    carsProvider = Provider.of<CarProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    carsProvider.restLatestCar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
            appBar: AppBar(
        title: Text(
          "Latest Car",
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
        if (carProvider.latestCarLoading && carProvider.latestCars.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              color: tdBlueLight,
            ),
          );
        }

        if (carProvider.latestCars.isEmpty) {
          return Center(
            child: Text(
              'No more car found',
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
            itemCount: carProvider.latestCars.length +
                (carProvider.latestCarHasMoreData ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == carProvider.latestCars.length) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: tdBlueLight,
                  ),
                );
              }
              final car = carProvider.latestCars[index];
              return CarCard(car: car) ;
            });
      }),
    );
  }
}