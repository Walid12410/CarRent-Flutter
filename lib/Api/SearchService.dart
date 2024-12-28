import 'package:carrent/core/ApiEndPoint.dart';
import 'package:carrent/model/Car/CarModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchService {
  Future<List<Car>> searchCars(String searchQuery) async {
    try {
      final response = await http.post(
          Uri.parse('${ApiEndpoints.apiUrl}/api/car-rent/search'),
          body: jsonEncode({'carModel': searchQuery}));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> carsJson = data['data'];
        return carsJson.map((car) => Car.fromJson(car)).toList();
      } else {
        throw Exception('Failed to load user reviews');
      }
    } catch (e) {
      throw Exception('Server Error $e');
    }
  }

    Future<List<Car>> searchCompanyCar(String searchQuery,String companyId) async {
    try {
      final response = await http.post(
          Uri.parse('${ApiEndpoints.apiUrl}/api/car-rent/search'),
          body: jsonEncode({'carModel': searchQuery,'companyId' : companyId}));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> carsJson = data['data'];
        return carsJson.map((car) => Car.fromJson(car)).toList();
      } else {
        throw Exception('Failed to load user reviews');
      }
    } catch (e) {
      throw Exception('Server Error $e');
    }
  }
}
