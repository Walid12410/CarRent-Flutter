import 'dart:convert';
import 'package:carrent/Widget/Toast/ToastError.dart';
import 'package:carrent/core/ApiEndPoint.dart';
import 'package:carrent/core/Time/CurrentTime.dart';
import 'package:http/http.dart' as http;
import 'package:carrent/model/Booking/BookingModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingService {
  Future<List<Booking>> fetchUserBooking() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken') ?? '';
    String id = prefs.getString('userId') ?? "";

    try {
      final response = await http
          .get(Uri.parse('${ApiEndpoints.apiUrl}/api/booking/$id'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Booking> allUserBooking =
            jsonData.map((json) => Booking.fromJson(json)).toList();
        return allUserBooking;
      } else {
        showToast('Failed to load user booking');
        throw Exception('Failed to load user booking');
      }
    } catch (e) {
      showToast('Server Error ');
      throw Exception('Server Error');
    }
  }

  Future<bool> createNewBooking(
      String carId,
      int daysRent,
      String totalRentPrice,
      double carPrice,
      int discountPercentage,
      String? promoCode,
      String startDate,
      String endDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken') ?? '';
    String currentTime =  getCurrentTimeInISO();

    final body = jsonEncode({
      "daysRent": daysRent,
      "totalRentPrice": totalRentPrice,
      if (promoCode != null) 'promoCode': promoCode,
      "mainCarPrice": carPrice,
      "discountPercent": discountPercentage,
      "startDate": startDate,
      "endDate": endDate,
    });

    try {
      final response = await http.post(
          Uri.parse('${ApiEndpoints.apiUrl}/api/booking/$carId?currentTime=$currentTime'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: body);

      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 201) {
        showToast(responseBody['message']);
        return true;
      } else {
        showToast(responseBody['message']);
        return false;
      }
    } catch (e) {
      showToast('Something went wrong');
      return false;
    }
  }
}
