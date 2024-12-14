import "package:carrent/Widget/Car/CarCategoryCard.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/provider/Car_Provider.dart";
import "package:carrent/provider/Category_Provider.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

class CarCategoryListPage extends StatefulWidget {
  const CarCategoryListPage({super.key, required this.categoryId});

  final String categoryId;
  @override
  State<CarCategoryListPage> createState() => _CarCategoryListPageState();
}

class _CarCategoryListPageState extends State<CarCategoryListPage> {
  late ScrollController _scrollController;
  late CarProvider carsProvider;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      carsProvider.fetchCategoryCar(widget.categoryId);
    });
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 200) {
      Provider.of<CarProvider>(context, listen: false)
          .fetchCategoryCar(widget.categoryId);
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
    carsProvider.restCarCategory();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context, listen: true);
    String categoryName = category.getCategoryNameById(widget.categoryId);

    return Scaffold(
      backgroundColor: tdWhite,
      appBar: AppBar(
        title: Text(
          categoryName,
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
      ),
      body: Consumer<CarProvider>(builder: (context, carProvider, child) {
        if (carProvider.isLoadingCatCar && carProvider.categoryCars.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              color: tdBlueLight,
            ),
          );
        }

        if (carProvider.categoryCars.isEmpty) {
          return Center(
            child: Text(
              'No more car found for this category',
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
            itemCount: carProvider.categoryCars.length +
                (carProvider.catCarHasMoreData ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == carProvider.categoryCars.length) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: tdBlueLight,
                  ),
                );
              }
              final car = carProvider.categoryCars[index];
              return Padding(
                padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 5, bottom: 10)
                    .w,
                child: CarCategoryCard(car: car),
              );
            });
      }),
    );
  }
}
