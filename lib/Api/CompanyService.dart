import 'dart:convert';
import 'package:carrent/Widget/ToastError.dart';
import 'package:http/http.dart' as http;
import '../core/ApiEndPoint.dart';
import 'package:carrent/model/Company/CompanyModel.dart';

class CompanyService {
  Future<List<Company>> fetchLatestCompany() async {
    try {
      final response = await http
          .get(Uri.parse('${ApiEndpoints.apiUrl}/api/company/list?top=3'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Company> latestCompany =
            jsonData.map((json) => Company.fromJson(json)).toList();
        return latestCompany;
      } else {
        showToast('Falid to load latest company ${response.statusCode}');
        throw Exception('Failed to load latest company');
      }
    } catch (e) {
      showToast('Server Error');
      throw Exception('Server Error');
    }
  }
}
