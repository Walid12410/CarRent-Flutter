import 'dart:convert';
import 'package:carrent/Widget/Toast/ToastError.dart';
import 'package:carrent/Widget/Toast/ToastSuccess.dart';
import 'package:carrent/model/Promo/GetPromoModel.dart';
import 'package:carrent/model/Promo/PromoDetailsModel.dart';
import 'package:carrent/model/Promo/PromoModel.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/ApiEndPoint.dart';

class PromoService {
  Future<List<Promo>> fetchPromo(
      int pageNumber, String currentTime, int pageLimit) async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.apiUrl}/api/promo?pageNumber=$pageNumber&currentTime=$currentTime&limitPage=$pageLimit'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Promo> promo =
            jsonData.map((json) => Promo.fromJson(json)).toList();
        return promo;
      } else {
        showToast('Falid to load promo ');
        throw Exception('Failed to load Promo');
      }
    } catch (e) {
      showToast('Server Error');
      throw Exception('Server Error');
    }
  }

  Future<PromoDetails> fetchOnePromo(String promoId) async {
    try {
      final response = await http
          .get(Uri.parse('${ApiEndpoints.apiUrl}/api/promo/$promoId'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        PromoDetails promoDetails = PromoDetails.fromJson(jsonData);
        return promoDetails;
      } else {
        showToast('Falid to load promo details');
        throw Exception('Failed to load promo details');
      }
    } catch (e) {
      showToast('Server Error');
      throw Exception('Server Error $e');
    }
  }

  Future<List<GetPromo>> fetchUserPromo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken') ?? '';

    try {
      final response = await http.get(
        Uri.parse('${ApiEndpoints.apiUrl}/api/promo/user-promo'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<GetPromo> userPromo =
            jsonData.map((json) => GetPromo.fromJson(json)).toList();
        return userPromo;
      } else {
        showToast('Falid to load user promo');
        throw Exception('Failed to load user promo');
      }
    } catch (e) {
      showToast('Server Error');
      throw Exception('Server Error');
    }
  }

  Future<bool> getPromo(String promoId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken') ?? '';
    final formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final url = Uri.parse('${ApiEndpoints.apiUrl}/api/promo/claim/$promoId');

    try {
      final body = jsonEncode({"claimAt": formattedDate});

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: body);

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 201) {
        showSucessToast('Promotion claimed successfully');
        return true;
      } else if (response.statusCode == 400) {
        showToast(responseBody['message']);
        return false;
      } else if (response.statusCode == 404) {
        showToast(responseBody['message']);
        return false;
      } else {
        showToast('Something went wrong');
        return false;
      }
    } catch (e) {
      showToast('Something went wrong, check you connection');
      return false;
    }
  }
}
