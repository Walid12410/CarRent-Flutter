import 'dart:convert';
import 'package:http/http.dart' as http;
import '../ApiEndPoint.dart';
import 'package:carrent/model/Company/CompanyModel.dart';

class CompanyService{

  Future<List<Company>> fetchLatestCompany() async {
    try {
      final response = await http.get(Uri.parse('${ApiEndpoints.apiUrl}/api/company/list?top=3'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Company> latestCompany = jsonData.map((json) => Company.fromJson(json)).toList();
        return latestCompany;
      } else {
        throw Exception('Failed to load latest Company');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }


}