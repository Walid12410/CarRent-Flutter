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

  void removeUserReviewById(String reviewId) {
  // Remove the review with the given ID
  _userReview.removeWhere((review) => review.id == reviewId);
  notifyListeners();
}


  // car reviews pagination
  final List<Review> _carReview = [];
  bool _isLoading = false;
  int _currentPage = 1;
  final int _perPage = 12;
  bool _hasMoreData = true;

  List<Review> get carReview => _carReview;
  bool get isLoading => _isLoading;
  bool get hasMoreData => _hasMoreData;

  Future<void> fetchCarReview(String carId) async {
    if (_isLoading || !_hasMoreData) return;
    _isLoading = true;
    notifyListeners();

    try {
      List<Review> newReviews =
          await service.fetchCarReview(_currentPage, _perPage, carId);
      if (newReviews.length < _perPage) {
        _hasMoreData = false;
      } else {
        _currentPage++;
      }
      for (var review in newReviews) {
        if (!_carReview.any((existingCar) => existingCar.id == review.id)) {
          _carReview.add(review);
        }
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetCarReview() {
    _carReview.clear();
    _currentPage = 1;
    _hasMoreData = true;
  }
}
