import 'dart:convert';
import 'package:carrent/Widget/Toast/ToastError.dart';
import 'package:carrent/model/Offer/OfferModel.dart';
import 'package:http/http.dart' as http;
import '../core/ApiEndPoint.dart';

class OfferService {
  Future<List<Offer>> fetchOffer(String time, int page, int limit) async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.apiUrl}/api/offer?currentTime=$time&page=$page&limit=$limit'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Offer> offer =
            jsonData.map((json) => Offer.fromJson(json)).toList();
        return offer;
      } else {
        showToast('Falid to load offer');
        throw Exception('Failed to load Offer');
      }
    } catch (e) {
      showToast('Server Error');
      throw Exception('Server Error');
    }
  }

  Future<List<Offer>> fetchCarOffer(String carId, String time) async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.apiUrl}/api/offer/check-car/$carId?currentTime=$time'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Offer> offer =
            jsonData.map((json) => Offer.fromJson(json)).toList();
        return offer;
      } else {
        showToast('Falid to load offer');
        throw Exception('Failed to load Offer');
      }
    } catch (e) {
      showToast('Server Error');
      throw Exception('Server Error');
    }
  }
}
