import 'package:carrent/Widget/Toast/ToastError.dart';
import 'package:carrent/Widget/Toast/ToastSuccess.dart';
import 'package:carrent/Widget/Toast/ToastValidation.dart';
import 'package:carrent/core/ApiEndPoint.dart';
import 'package:carrent/model/Review/ReviewModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ReviewService {
  Future<bool> createReview(
      int reviewRate, String reviewText, String carId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken') ?? '';
    try {
      final body = jsonEncode({'rate': reviewRate, 'reviewText': reviewText});

      final response = await http.post(
          Uri.parse('${ApiEndpoints.apiUrl}/api/review/$carId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: body);

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 201) {
        showSucessToast('Review added to this car!');
        return true;
      } else if (response.statusCode == 400) {
        showValidationToast(responseBody['message']);
        return false;
      } else {
        showToast(responseBody['message']);
        return false;
      }
    } catch (e) {
      showToast('Something went wrong, check you connection');
      return false;
    }
  }

    Future<bool> deleteReview(String reviewId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken') ?? '';
    try {
      final response = await http.delete(
          Uri.parse('${ApiEndpoints.apiUrl}/api/review/$reviewId'),
          headers: {
            'Authorization': 'Bearer $token'
          },
      );
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showSucessToast('Review deleted successfully!');
        return true;
      } else if (response.statusCode == 404) {
        showValidationToast(responseBody['message']);
        return false;
      } else {
        showToast(responseBody['message']);
        return false;
      }
    } catch (e) {
      showToast('Something went wrong, check you connection');
      return false;
    }
  }


  Future<bool> updateReview(String reviewId, int reviewRate, String reviewText) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken') ?? '';
    try {
      final body = jsonEncode({'rate': reviewRate, 'reviewText': reviewText});

      final response = await http.put(
          Uri.parse('${ApiEndpoints.apiUrl}/api/review/$reviewId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: body);

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 201) {
        showSucessToast('Review updated successfully!');
        return true;
      } else if (response.statusCode == 400) {
        showValidationToast(responseBody['message']);
        return false;
      } else {
        showToast(responseBody['message']);
        return false;
      }
    } catch (e) {
      showToast('Something went wrong, check you connection');
      return false;
    }
  }

  Future<List<Review>> fetchAllUserReview() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken') ?? '';
    String id = prefs.getString('userId') ?? "";

    try {
      final response = await http.get(
          Uri.parse('${ApiEndpoints.apiUrl}/api/review/user-review/$id'),
          headers: {'Authorization': "Bearer $token"});
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Review> userReview =
            jsonData.map((json) => Review.fromJson(json)).toList();
        return userReview;
      } else {
        throw Exception('Failed to load user reviews');
      }
    } catch (e) {
      throw Exception('Server Error $e');
    }
  }

  Future<List<Review>> fetchCarReview(int page, int limit,String carId) async {
    try {
      final response = await http.get(
          Uri.parse('${ApiEndpoints.apiUrl}/api/review/$carId?pageNumber=$page&limitPerPage=$limit'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Review> carReviews =
            jsonData.map((json) => Review.fromJson(json)).toList();
        return carReviews;
      } else {
        throw Exception('Failed to load car reviews');
      }
    } catch (e) {
      throw Exception('Server Error $e');
    }
  }

}
