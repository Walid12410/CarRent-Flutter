import "dart:async";
import "package:carrent/Widget/Car/SearchCarCard.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/model/Car/CarMakeModel.dart";
import "package:carrent/model/Car/CarModel.dart";
import "package:carrent/model/Category/CategoryModel.dart";
import "package:carrent/provider/Car_Provider.dart";
import "package:carrent/provider/Category_Provider.dart";
import "package:carrent/provider/Search_Provider.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<void> _fetchDataFuture;
  final TextEditingController _searchController = TextEditingController();
  double minValue = 15.0;
  double maxValue = 250.0;
  String? carMakeSelected; // Add this variable at the top
  List<String> categorySelected = [];
  bool showAllCategories = false;
  bool showAllCarModels = false;
  String _searchQuery = '';
  int _currentPage = 1;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    if (_debounce != null) {
      _debounce?.cancel();
    }
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    final filterSearch = Provider.of<SerachProvider>(context, listen: false);
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _searchQuery = query;
        _currentPage = 1;
      });
      // Trigger the search when the user stops typing
      Provider.of<SerachProvider>(context, listen: false).fetchSearch(
          _currentPage,
          _searchQuery,
          filterSearch.selectedCategories,
          filterSearch.currentMinValue,
          filterSearch.currentMaxValue,
          filterSearch.selectedCarMake);
    });
  }

  void _loadMore() {
    final filterSearch = Provider.of<SerachProvider>(context, listen: false);
    if (_currentPage * 10 < filterSearch.totalResults) {
      setState(() {
        _currentPage++;
      });
      Provider.of<SerachProvider>(context, listen: false).fetchSearch(
          _currentPage,
          _searchQuery,
          filterSearch.selectedCategories,
          filterSearch.currentMinValue,
          filterSearch.currentMaxValue,
          filterSearch.selectedCarMake);
    }
  }

  Future<void> _fetchData() async {
    final car = Provider.of<CarProvider>(context, listen: false);
    final category = Provider.of<CategoryProvider>(context, listen: false);
    final filterProvider = Provider.of<SerachProvider>(context, listen: false);
    await filterProvider.init();
    await car.getAllCarMake();
    await category.getAllCategory();
  }

  // Function to show the dialog
  void _showFilterDialog(List<CarMake> carModel, List<Category> categoryList) {
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
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20).w,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setDialogState) {
              // This allows us to call setState() inside the dialog
              final filterProvider =
                  Provider.of<SerachProvider>(context, listen: false);
              double currentMinValue = filterProvider.currentMinValue;
              double currentMaxValue = filterProvider.currentMaxValue;
              String? currentSelectedCarMake = filterProvider.selectedCarMake;
              List<String> selectedCategories =
                  filterProvider.selectedCategories;
              maxValue = currentMaxValue;
              minValue = currentMinValue;
              carMakeSelected = currentSelectedCarMake;

              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filter',
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: tdBlueLight,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            filterProvider.init();
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: tdGrey,
                            size: 20.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text('Price',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: tdBlueLight,
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      width: 500.w,
                      child: RangeSlider(
                        values: RangeValues(minValue, maxValue),
                        min: 0,
                        max: 500,
                        divisions: 50,
                        activeColor:
                            tdBlue, // Set the active track color to blue
                        inactiveColor:
                            tdGrey, // Set the inactive track color to a lighter blue
                        onChanged: (RangeValues values) {
                          setDialogState(() {
                            minValue = values.start;
                            maxValue = values.end;
                            filterProvider.setPriceRange(minValue, maxValue);
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                              border: Border.all(color: tdGrey),
                              borderRadius: BorderRadius.circular(10).w),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                    left: 10, top: 5, bottom: 5)
                                .w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'FROM',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: tdBlack,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  '\$$minValue / day',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: tdBlue),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                              border: Border.all(color: tdGrey),
                              borderRadius: BorderRadius.circular(10).w),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                    left: 10, top: 5, bottom: 5)
                                .w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'TO',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: tdBlack,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  '\$$maxValue / day',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: tdBlue),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // Categories Section
                    Text('Categories',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: tdBlueLight)),
                    ...List<Widget>.generate(
                      showAllCategories
                          ? categoryList.length
                          : 3, // Show first 3 or all categories
                      (index) {
                        return SizedBox(
                            height: 30.h,
                            child: CheckboxListTile(
                              title: Text(
                                categoryList[index].categoryName,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: tdBlueLight,
                                    fontWeight: FontWeight.w400),
                              ), // Show category name
                              value: selectedCategories.contains(
                                  categoryList[index].id), // Use categoryId
                              onChanged: (bool? selected) {
                                setDialogState(() {
                                  if (selected == true) {
                                    // Only add the selected category
                                    selectedCategories
                                        .add(categoryList[index].id);
                                  } else {
                                    // Only remove the deselected category
                                    selectedCategories
                                        .remove(categoryList[index].id);
                                  }
                                });
                              },
                              activeColor: tdBlue,
                            ));
                      },
                    ),
                    if (!showAllCategories)
                      TextButton(
                        onPressed: () {
                          setDialogState(() {
                            showAllCategories = true;
                          });
                        },
                        child: Center(
                          child: Text(
                            'See more categories',
                            style: TextStyle(
                                color: tdBlue,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                    if (showAllCategories && categoryList.length > 3)
                      TextButton(
                        onPressed: () {
                          setDialogState(() {
                            showAllCategories = false;
                          });
                        },
                        child: Center(
                          child: Text(
                            'See less category',
                            style: TextStyle(
                                color: tdBlue,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                    Text('Car Model',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: tdBlueLight)),
                    ...List<Widget>.generate(
                      showAllCarModels
                          ? carModel.length
                          : 3, // Show first 3 or all car models
                      (index) {
                        return SizedBox(
                          height: 30.h,
                          child: RadioListTile<String>(
                            value: carModel[index].id.toString(),
                            groupValue:
                                carMakeSelected, // Holds the selected car model
                            onChanged: (String? value) {
                              setDialogState(() {
                                carMakeSelected =
                                    value; // Set the selected car model
                                filterProvider.setCarMake(carMakeSelected);
                              });
                            },
                            activeColor: tdBlue,
                            title: Text(
                              carModel[index].carMakeName,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: tdBlueLight,
                                  fontWeight: FontWeight.w400),
                            ), // Display car model name
                          ),
                        );
                      },
                    ),

                    if (carModel.length > 3 && !showAllCarModels)
                      TextButton(
                        onPressed: () {
                          setDialogState(() {
                            showAllCarModels = true;
                          });
                        },
                        child: Center(
                          child: Text(
                            'See more car model',
                            style: TextStyle(
                                color: tdBlue,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    if (showAllCarModels && carModel.length > 3)
                      TextButton(
                        onPressed: () {
                          setDialogState(() {
                            showAllCarModels = false;
                          });
                        },
                        child: Center(
                          child: Text(
                            'See less car model',
                            style: TextStyle(
                                color: tdBlue,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Apply all filter
                            filterProvider.applyFilter();
                            // pop dialog
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 120.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12).w,
                                color: tdBlueLight),
                            child: Center(
                              child: Text(
                                'Apply filter',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: tdWhite,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Clear filter
                            filterProvider.clearFilter();
                            // pop dialog
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 120.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12).w,
                                color: tdBlueLight),
                            child: Center(
                              child: Text(
                                'Clear filter',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: tdWhite,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final car = Provider.of<CarProvider>(context, listen: false);
    var carModels = car.carMake; // Get car models from CarProvider
    final categoryList = Provider.of<CategoryProvider>(context)
        .allCategory; // Get categories from CategoryProvider

    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: FutureBuilder(
            future: _fetchDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: tdBlueLight,
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20).w,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          IconButton(
                              onPressed: () {
                                GoRouter.of(context).go('/home');
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 20.w,
                                color: tdGrey,
                              )),
                          SizedBox(
                            height: 20.w,
                          ),
                          Container(
                            width: double.infinity,
                            height: 40.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12).w,
                                border: Border.all(color: tdGrey)),
                            child: Padding(
                              padding: const EdgeInsets.all(5).w,
                              child: TextField(
                                cursorColor: tdGrey,
                                controller: _searchController,
                                onChanged: (value) {
                                  _onSearchChanged(_searchController.text);
                                },
                                style: TextStyle(
                                    fontSize: 12.sp, color: tdBlueLight),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search for special car",
                                    hintStyle: TextStyle(
                                        color: tdGrey, fontSize: 12.sp),
                                    prefixIcon: Icon(
                                      Icons.search_rounded,
                                      color: tdGrey,
                                      size: 20.w,
                                    )),
                              ),
                            ),
                          ),
                          Consumer<SerachProvider>(
                            builder: (context, carProvider, child) {
                              return carProvider.isLoading &&
                                      carProvider.cars.isEmpty
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: tdBlueLight,
                                    ))
                                  : SizedBox(
                                      height: 700.h,
                                      child: ListView.builder(
                                        itemCount: carProvider.cars.length +
                                            (carProvider.isLoading ? 1 : 0),
                                        itemBuilder: (context, index) {
                                          if (index ==
                                                  carProvider.cars.length &&
                                              carProvider.isLoading) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: tdBlueLight,
                                            ));
                                          }
                                          Car car = carProvider.cars[index];
                                          return SearchCarCard(car: car);
                                        },
                                        controller: ScrollController()
                                          ..addListener(() {
                                            if (Provider.of<SerachProvider>(
                                                        context,
                                                        listen: false)
                                                    .cars
                                                    .isNotEmpty &&
                                                Provider.of<SerachProvider>(
                                                            context,
                                                            listen: false)
                                                        .isLoading ==
                                                    false &&
                                                !Provider.of<SerachProvider>(
                                                        context,
                                                        listen: false)
                                                    .isLoading &&
                                                _currentPage * 10 <
                                                    Provider.of<SerachProvider>(
                                                            context,
                                                            listen: false)
                                                        .totalResults) {
                                              _loadMore();
                                            }
                                          }),
                                      ),
                                    );
                            },
                          ),
                        ]),
                  ),
                );
              }
            }),
      ),
      bottomNavigationBar: BottomAppBar(
        color: tdWhite,
        surfaceTintColor: tdWhite,
        shadowColor: tdWhite,
        child: Padding(
          padding: const EdgeInsets.only(left: 110, right: 110, top: 12).w,
          child: Container(
            decoration: BoxDecoration(
                color: tdBlueLight, borderRadius: BorderRadius.circular(15).w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    context.push(context.namedLocation('GoogleMap'));
                  },
                  child: Row(children: [
                    Icon(
                      Icons.location_on_sharp,
                      color: tdWhite,
                      size: 15.w,
                    ),
                    Text(
                      'Maps',
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: tdWhite,
                          fontWeight: FontWeight.w400),
                    )
                  ]),
                ),
                SizedBox(
                  width: 5.w,
                ),
                GestureDetector(
                  onTap: () {
                    _showFilterDialog(carModels, categoryList);
                  },
                  child: Row(children: [
                    Icon(
                      Icons.filter_alt,
                      color: tdWhite,
                      size: 15.w,
                    ),
                    Text(
                      'Filter ',
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: tdWhite,
                          fontWeight: FontWeight.w400),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
