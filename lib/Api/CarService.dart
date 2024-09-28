import 'dart:convert';
import 'package:carrent/model/Car/CarModel.dart';
import 'package:http/http.dart' as http;
import '../ApiEndPoint.dart';



class CarService{

  Future<List<Car>> fetchLatestCar(int pageNumber) async {
    try {
      final response = await http.get(Uri.parse('${ApiEndpoints.apiUrl}/api/car-rent?pageNumber=$pageNumber'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Car> latestPromo = jsonData.map((json) => Car.fromJson(json)).toList();
        return latestPromo;
      } else {
        throw Exception('Failed to load latest car');
      }
    } catch (e) {
      throw Exception('Server Error');
    }
  }

}