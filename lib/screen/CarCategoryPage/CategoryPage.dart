import 'package:carrent/core/Color/color.dart';
import 'package:carrent/provider/Category_Provider.dart';
import 'package:carrent/screen/CarCategoryPage/Details/CarCategoryView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CarCategoryPage extends StatefulWidget {
  const CarCategoryPage({super.key});

  @override
  State<CarCategoryPage> createState() => _CarCategoryPageState();
}

class _CarCategoryPageState extends State<CarCategoryPage> {
  late Future<void> _fetchDataFuture;
  int _selectIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    final category = Provider.of<CategoryProvider>(context, listen: false);
    category.getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context, listen: true);
    var categories = category.allCategory;

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
                      SizedBox(height: 10.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20).w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                              height: 10.h,
                            ),
                            Text(
                              'Category',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  color: tdBlueLight),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      categories.isNotEmpty
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15).w,
                                  child: SizedBox(
                                    height: 35.h,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: categories.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectIndex = index;
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5).w,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: _selectIndex == index ? tdBlue : tdWhite,
                                                    borderRadius: BorderRadius.circular(10).w,
                                                    border: Border.all(color: _selectIndex == index ? tdBlue : tdGrey)),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(5).w,
                                                  child: Text(
                                                    categories[index].categoryName,
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: _selectIndex == index ? tdWhite : tdBlueLight,
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                                IntrinsicHeight(
                                    child:
                                        categories[_selectIndex].categoryName != ""
                                            ? CarCategoryView(
                                                categoryId: categories[_selectIndex].id)
                                            : Text(
                                                'No car added yet',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.sp,
                                                    color: tdGrey),
                                              ))
                              ],
                            )
                          : Center(
                              child: Text('No car added yet' ,style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold,
                              color: tdGrey),),
                            )
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
