import "dart:math";

import "package:carrent/core/Color/color.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  double _currentMinValue = 15.0;
  double _currentMaxValue = 250.0;

  // Function to show the dialog
  void _showClearCartDialog() {
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
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter',
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
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
                  Text(
                    'Price',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)
                  ),
                  SizedBox(
                    width: 500.w,
                    child: RangeSlider(
                      values: RangeValues(_currentMinValue, _currentMaxValue),
                      min: 0,
                      max: 500,
                      divisions: 50,
                      activeColor: tdBlue,  // Set the active track color to blue
                      inactiveColor: tdGrey,  // Set the inactive track color to a lighter blue
                      onChanged: (RangeValues values) {
                        setDialogState(() {
                          // Update the local values for the dialog
                          _currentMinValue = values.start;
                          _currentMaxValue = values.end;
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
                                '\$$_currentMinValue / day',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: tdBlue),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w,),
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
                                '\$$_currentMaxValue / day',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: tdBlue),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
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
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search for special car",
                            hintStyle:
                                TextStyle(color: tdGrey, fontSize: 12.sp),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: tdGrey,
                              size: 20.w,
                            )),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: tdWhite,
        surfaceTintColor: tdWhite,
        shadowColor: tdWhite,
        child: Padding(
          padding: const EdgeInsets.only(left: 110, right: 110).w,
          child: Container(
            decoration: BoxDecoration(
                color: tdBlueLight, borderRadius: BorderRadius.circular(17).w),
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
                      style: TextStyle(fontSize: 12.sp, color: tdWhite),
                    )
                  ]),
                ),
                SizedBox(
                  width: 5.w,
                ),
                GestureDetector(
                  onTap: () {
                    _showClearCartDialog();
                  },
                  child: Row(children: [
                    Icon(
                      Icons.filter_alt,
                      color: tdWhite,
                      size: 15.w,
                    ),
                    Text(
                      'Filter',
                      style: TextStyle(fontSize: 12.sp, color: tdWhite),
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
