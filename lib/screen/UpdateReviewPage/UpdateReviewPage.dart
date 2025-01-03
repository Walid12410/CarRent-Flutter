import "package:cached_network_image/cached_network_image.dart";
import "package:carrent/Api/ReviewService.dart";
import "package:carrent/Widget/Toast/ToastError.dart";
import "package:carrent/Widget/Toast/ToastValidation.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/model/Car/CarModel.dart";
import "package:carrent/provider/Review_Provider.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

class UpdateReviewPage extends StatefulWidget {
  const UpdateReviewPage({super.key, required this.car});

  final Car car;
  @override
  State<UpdateReviewPage> createState() => _UpdateReviewPageState();
}

class _UpdateReviewPageState extends State<UpdateReviewPage> {
  int _selectedStars = 0;
  late TextEditingController _textReview = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final review = Provider.of<ReviewProvider>(context, listen: false);
      var userReview = review.userReview;

      bool hasReview =
          userReview.any((review) => review.carId == widget.car.id);

      if (hasReview) {
        setState(() {
          _selectedStars = userReview
              .firstWhere((review) => review.carId == widget.car.id)
              .rate;
          _textReview = TextEditingController(
              text: userReview
                  .firstWhere((review) => review.carId == widget.car.id)
                  .reviewText);
        });
      } else {
        GoRouter.of(context).pop();
      }
    });
  }

  void updateReview(int star, String text, String reviewId) async {
    ReviewService service = ReviewService();
    final review = Provider.of<ReviewProvider>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    try {
      if (star == 0) {
        showValidationToast('rating star is required');
        return;
      }
      if (text == "" || text.isEmpty) {
        showValidationToast('review Text is required');
        return;
      }
      bool isUpdated = await service.updateReview(reviewId, star, text);
      if (isUpdated) {
        review.getAllUserReview();
        setState(() {
          context.pop();
        });
      }
    } catch (e) {
      showToast('Something went wrong, check your connection');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context, listen: false);
    var userReview = reviewProvider.userReview;

    bool hasReview = userReview.any((review) => review.carId == widget.car.id);
    String? reviewId;

    if (hasReview) {
      reviewId =
          userReview.firstWhere((review) => review.carId == widget.car.id).id;
    }
    return Scaffold(
      backgroundColor: tdWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon:
                        Icon(Icons.arrow_back_ios, size: 20.w, color: tdGrey)),
                SizedBox(height: 10.h),
                Text(
                  "Update Review",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: tdBlueLight,
                  ),
                ),
                SizedBox(height: 15.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 90.w,
                        height: 70.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12).w,
                          child: CachedNetworkImage(
                            imageUrl: (widget.car.carImage.isNotEmpty)
                                ? widget.car.carImage[0].carImage.url
                                : 'https://www.its.ac.id/tmesin/wp-content/uploads/sites/22/2022/07/no-image.png',
                            fit: BoxFit.fill,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: tdBlueLight,
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    // Dealer Name and Location
                    Text(
                      "${widget.car.carMake.carMakeName} ${widget.car.carModel} - ${widget.car.year}",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: tdBlueLight,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedStars =
                              index + 1; // Save the selected star rating
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10).w,
                        child: Icon(
                          index < _selectedStars
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 35,
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 40.h),
                // Write Review Section
                Text(
                  "Write review",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: tdBlueLight,
                  ),
                ),
                SizedBox(height: 5.h),
                // Comment Box
                TextField(
                  maxLines: 8,
                  controller: _textReview,
                  cursorColor: tdBlueLight,
                  decoration: InputDecoration(
                    hintText: "Tell us about this car and company service",
                    hintStyle: TextStyle(color: tdGrey, fontSize: 12.sp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: tdBlue, width: 1.5),
                      borderRadius: BorderRadius.circular(12).w,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: tdWhite,
        shadowColor: tdWhite,
        surfaceTintColor: tdWhite,
        height: 70.h,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15).w,
          child: GestureDetector(
            onTap: isLoading
                ? null
                : () {
                    updateReview(
                        _selectedStars, _textReview.text, reviewId.toString());
                  },
            child: Container(
              width: double.infinity,
              height: 40.h,
              decoration: BoxDecoration(
                  color: tdBlueLight,
                  borderRadius: BorderRadius.circular(12).w),
              child: Center(
                child: Text(
                  isLoading ? "Updating..." : "Update review",
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: tdWhite,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}