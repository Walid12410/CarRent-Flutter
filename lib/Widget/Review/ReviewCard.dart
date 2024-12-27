import "package:cached_network_image/cached_network_image.dart";
import "package:carrent/Widget/StarRating.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/model/Review/ReviewModel.dart";
import "package:carrent/provider/Review_Provider.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:provider/provider.dart";

class ReviewCard extends StatelessWidget {
  const ReviewCard(
      {super.key,
      required this.review,
      required this.formattedDate,
      });

  final Review review;
  final String formattedDate;

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context, listen: true);
    var userReview = reviewProvider.userReview;

    bool hasReview =
        userReview.any((isReview) => isReview.userId == review.userId);

    return hasReview
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 35.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: tdGrey, width: 0.2.w),
                      borderRadius: BorderRadius.circular(12).w,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12).w,
                      child: CachedNetworkImage(
                        imageUrl: review.userDetails!.photo!.url,
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
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${review.userDetails!.firstName} ${review.userDetails!.lastName}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: tdBlueLight,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow
                                    .ellipsis, // Ensures text doesn't overflow
                              ),
                            ),
                            SizedBox(
                                width: 8.w), // Add space between name and date
                            Text(
                              formattedDate,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: tdGrey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        StarRating(rating: review.rate.toDouble()),
                        SizedBox(height: 2.h),
                        Text(
                          "`${review.reviewText}`",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: tdGrey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              )
            ],
          );
  }
}
