import 'package:carrent/core/Color/color.dart';
import 'package:carrent/provider/Feature_Provider.dart';
import 'package:carrent/Widget/Car/CarCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RentWayPage extends StatefulWidget {
  const RentWayPage({super.key});

  @override
  State<RentWayPage> createState() => _RentWayPageState();
}

class _RentWayPageState extends State<RentWayPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FeatureProvider>(context, listen: false).fetchFeatures();
    });
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 200) {
      Provider.of<FeatureProvider>(context, listen: false).fetchFeatures();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      appBar: AppBar(
        title: Text(
          'RentWay!',
          style: TextStyle(
              fontSize: 15.sp, color: tdBlueLight, fontWeight: FontWeight.bold),
        ),
        backgroundColor: tdWhite,
        shadowColor: tdWhite,
        surfaceTintColor: tdWhite,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20).w,
          child: IconButton(
              onPressed: () {
                GoRouter.of(context).go('/home');
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20.w,
                color: tdGrey,
              )),
        ),
      ),
      body: Consumer<FeatureProvider>(
        builder: (context, featureProvider, child) {
          if (featureProvider.isLoading && featureProvider.features.isEmpty) {
            return const Center(
                child: CircularProgressIndicator(color: tdBlueLight));
          }
          if (featureProvider.features.isEmpty) {
            return Center(
              child: Text(
                'No Rent added yet',
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
            itemCount: featureProvider.features.length +
                (featureProvider.hasMoreData ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == featureProvider.features.length) {
                return const Center(
                    child: CircularProgressIndicator(color: tdBlueLight));
              }
              final feature = featureProvider.features[index];
              return CarCard(car: feature.car!);
            },
          );
        },
      ),
    );
  }
}
