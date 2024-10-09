import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrent/core/Color/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carrent/model/Car/CarImageModel.dart'; // Assuming CarImageModel exists

class CarImagePageView extends StatefulWidget {
  const CarImagePageView({super.key, required this.carImages});
  
  final List<CarImage> carImages;

  @override
  _CarImagePageViewState createState() => _CarImagePageViewState();
}

class _CarImagePageViewState extends State<CarImagePageView> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 180.h, // Adjust height to fit both the image and the indicator
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemCount: widget.carImages.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: widget.carImages[index].carImage.url,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: tdBlueLight,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: double.infinity,
              );
            },
          ),
          Positioned(
            top: 15.0.h,
            left: 15.0.w,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20.w,
              ),
              color: tdWhite, // Icon color
              onPressed: () {
                context.pop();
              },
            ),
          ),
          Positioned(
            bottom: 10.h,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: widget.carImages.length,
              effect: ExpandingDotsEffect(
                activeDotColor: tdBlueLight,
                dotHeight: 8.0.h,
                dotWidth: 8.0.w,
                expansionFactor: 4.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
