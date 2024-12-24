import "package:awesome_dialog/awesome_dialog.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:carrent/Widget/StarRating.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/model/Review/ReviewModel.dart";
import "package:carrent/model/User/UserModel.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:intl/intl.dart";

class UserReviewCard extends StatelessWidget {
  const UserReviewCard(
      {super.key, required this.reviewUser, required this.user});

  final Review? reviewUser;
  final User? user;

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate =
        DateTime.parse(reviewUser!.createdAt); // Parse the ISO date
    String formattedDate = DateFormat('MMM d, y').format(parsedDate);

    return Column(
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
                  imageUrl: user!.photo!.url,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: tdBlueLight,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                          '${user!.firstName} ${user!.lastName}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: tdBlueLight,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow
                              .ellipsis, // Ensures text doesn't overflow
                        ),
                      ),
                      SizedBox(width: 8.w), // Add space between name and date
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StarRating(rating: reviewUser!.rate.toDouble()),
                      GestureDetector(
                          onTap: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              headerAnimationLoop: false,
                              animType: AnimType.bottomSlide,
                              title: 'Are you sure?',
                              desc: 'Do you want to delete this rate?',
                              titleTextStyle: TextStyle(
                                  fontSize: 18.sp,
                                  color: tdBlack,
                                  fontWeight: FontWeight.bold),
                              descTextStyle: TextStyle(
                                  fontSize: 12.sp,
                                  color: tdBlack,
                                  fontWeight: FontWeight.w400),
                              btnCancelOnPress: () {
                                // Action when "Cancel" is pressed
                                print("Cancelled");
                              },
                              btnOkOnPress: () {
                                // Action when "Delete" is confirmed
                                print("Deleted");
                                // Add your delete logic here
                              },
                              btnCancelText: "Cancel",
                              btnOkText: "Delete",
                              btnOkColor: Colors.red,
                            ).show();
                          },
                          child: Icon(Icons.delete,
                              color: Colors.red, size: 20.w)),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "`${reviewUser!.reviewText}`",
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
