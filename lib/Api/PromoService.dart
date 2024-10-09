import 'dart:convert';
import 'package:carrent/model/Promo/PromoDetailsModel.dart';
import 'package:carrent/model/Promo/PromoModel.dart';
import 'package:http/http.dart' as http;
import '../core/ApiEndPoint.dart';

class PromoService {

  Future<List<Promo>> fetchPromo(int pageNumber, String currentTime, int pageLimit) async {
    try {
      final response = await http.get(
          Uri.parse('${ApiEndpoints.apiUrl}/api/promo?pageNumber=$pageNumber&currentTime=$currentTime&limitPage=$pageLimit'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Promo> promo =
            jsonData.map((json) => Promo.fromJson(json)).toList();
        return promo;
      } else {
        throw Exception('Failed to load Promo');
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
        return promoDetails;
      } else {
      throw Exception('Failed to load promo details');
      }
    } catch (e) {
      throw Exception('Server Error $e');
    }
  }

}
