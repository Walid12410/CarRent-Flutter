import 'package:carrent/Api/ReviewService.dart';
import 'package:carrent/model/Review/ReviewModel.dart';
import 'package:flutter/material.dart';

class ReviewProvider with ChangeNotifier {
  ReviewService service = ReviewService();

  // get all user review
  List<Review> _userReview = [];
  List<Review> get userReview => _userReview;
  getAllUserReview() async {
    final res = await service.fetchAllUserReview();
    _userReview = res;
    notifyListeners();
  }

  
}