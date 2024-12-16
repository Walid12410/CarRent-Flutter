import 'package:carrent/Widget/Toast/ToastError.dart';
import 'package:carrent/Widget/Toast/ToastSuccess.dart';
import 'package:carrent/Widget/Toast/ToastValidation.dart';
import 'package:carrent/core/ApiEndPoint.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class ReviewService {

  Future<bool> createReview(int reviewRate , String reviewText , String carId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken') ?? '';
    try {
      final body = jsonEncode({
        'rate' : reviewRate,
        'reviewText' : reviewText
      });

      final response = await http.post(
        Uri.parse('${ApiEndpoints.apiUrl}/api/review/$carId'),
        headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
        },
        body: body
      );

      final responseBody = jsonDecode(response.body);

      if(response.statusCode == 201) {
        showSucessToast('Review added to this car!');
        return true;
      }else if(response.statusCode == 400){
        showValidationToast(responseBody['message']);
        return false;
      }else{
        showToast(responseBody['message']);
        return false;
      }
    } catch (e) {
      showToast('Something went wrong, check you connection');
      return false;
    }
  }

}