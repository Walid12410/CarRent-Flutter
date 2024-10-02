import 'dart:convert';
import 'package:carrent/model/Promo/PromoDetailsModel.dart';
import 'package:carrent/model/Promo/PromoModel.dart';
import 'package:http/http.dart' as http;

import '../ApiEndPoint.dart';

class PromoService {
  Future<List<Promo>> fetchLatestPromo(int pageNumber) async {
    try {
      final response = await http.get(
          Uri.parse('${ApiEndpoints.apiUrl}/api/promo?pageNumber=$pageNumber'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Promo> latestPromo =
            jsonData.map((json) => Promo.fromJson(json)).toList();
        return latestPromo;
      } else {
        throw Exception('Failed to load latest Promo');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }

  Future<PromoDetails> fetchOnePromo(String promoId) async {
    try {
    final response = await http.get(Uri.parse('${ApiEndpoints.apiUrl}/api/promo/$promoId'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        PromoDetails promoDetails = PromoDetails.fromJson(jsonData);
        print(jsonData);
        print(promoDetails);
        return promoDetails;
      } else {
      throw Exception('Failed to load promo details');
      }
    } catch (e) {
      throw Exception('Server Error $e');
    }
  }

}
