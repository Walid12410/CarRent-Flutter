import 'package:carrent/core/Color/color.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'Details/PageViewController.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50.h),
              ExpandablePageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: const [
                  PageViewContainer(
                    imagePath: "assets/splash/splash1.jpg",
                    title: "Endless options",
                    desc:
                        "Choose from hundreds of models you won’t find anywhere else. Pick it up or get it delivered where you want it.",
                  ),
                  PageViewContainer(
                    imagePath: "assets/splash/splash3.jpg",
                    title: "Drive confidently",
                    desc:
                        "Drive confidently with your choice of protection plans. All plans include varying levels of insurance.",
                  ),
                  PageViewContainer(
                    imagePath: "assets/splash/splash2.jpg",
                    title: "24/7 Support",
                    desc:
                        "Rest easy knowing that everyone in RentWay community is screened and support roadside assistance.",
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                        3,
                        (index) => Container(
                          width: index == _currentPage ? 8.w : 5.w,
                          height: index == _currentPage ? 8.h : 5.h,
                          margin: EdgeInsets.symmetric(horizontal: 6.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == _currentPage ? tdBlueLight : tdGrey,
                          ),
                        ),
                      ),
                    ),
                    _currentPage == 2
                        ? GestureDetector(
                            onTap: () {
                              context.push("/LogIn");
                            },
                            child: Container(
                              width: 110.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10).w,
                                color: tdBlueLight,
                              ),
                              child: Center(
                                child: Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: tdWhite,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _pageController.animateToPage(
                                    2,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Container(
                                  width: 50.w,
                                  height: 30.h,
                                  color: tdWhite,
                                  child: Center(
                                    child: Text(
                                      'Skip',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: tdGrey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: 10.w), // Add spacing between buttons
                              GestureDetector(
                                onTap: () {
                                  // Go to the next page
                                  if (_currentPage < 2) {
                                    _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                child: Container(
                                  width: 60.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10).w,
                                    color: tdBlueLight,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Next',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: tdWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
