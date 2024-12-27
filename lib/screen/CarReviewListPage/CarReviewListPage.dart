import "package:carrent/Widget/Review/ReviewCard.dart";
import "package:carrent/core/Color/color.dart";
import "package:carrent/provider/Review_Provider.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:intl/intl.dart";
import "package:provider/provider.dart";

class CarReviewList extends StatefulWidget {
  const CarReviewList({super.key, required this.carId});

  final String carId;

  @override
  State<CarReviewList> createState() => _CarReviewListState();
}

class _CarReviewListState extends State<CarReviewList> {
  late ScrollController _scrollController;
  late ReviewProvider reviewProvider;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      reviewProvider.fetchCarReview(widget.carId);
    });
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 200) {
      Provider.of<ReviewProvider>(context, listen: false)
          .fetchCarReview(widget.carId);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reviewProvider = Provider.of<ReviewProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    reviewProvider.resetCarReview();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      appBar: AppBar(
        title: Text(
          "Car review",
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
      body: Consumer<ReviewProvider>(builder: (context, reviewProvide, child) {
        if (reviewProvide.isLoading && reviewProvide.carReview.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              color: tdBlueLight,
            ),
          );
        }

        if (reviewProvide.carReview.isEmpty) {
          return Center(
            child: Text(
              'No more review!',
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
            itemCount: reviewProvide.carReview.length +
                (reviewProvide.hasMoreData ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == reviewProvide.carReview.length) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: tdBlueLight,
                  ),
                );
              }
              final review = reviewProvide.carReview[index];
              DateTime parsedDate =
                  DateTime.parse(review.createdAt); // Parse the ISO date
              String formattedDate = DateFormat('MMM d, y').format(parsedDate);
              return Padding(
                padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 5, bottom: 10)
                    .w,
                child: ReviewCard(review: review,formattedDate: formattedDate)
              );
            });
      }),
    );
  }
}
