import 'dart:convert';
import 'dart:math';
import 'package:carrent/Widget/Toast/ToastError.dart';
import 'package:carrent/core/ApiEndPoint.dart';
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
          .get(Uri.parse('${ApiEndpoints.apiUrl}/api/booking/$id'),
          headers: {
            'Content-Type' : 'application/json',
            'Authorization' : 'Bearer $token'
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
      showToast('Server Error');
      throw Exception('Server Error');
    }
  }
}
