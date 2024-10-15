import 'dart:convert';
import 'package:carrent/Widget/ToastError.dart';
import 'package:carrent/model/Car/CarModel.dart';
import 'package:carrent/model/CarDetails/CarDetailsModel.dart';
import 'package:http/http.dart' as http;
import '../core/ApiEndPoint.dart';

class CarService {
  Future<List<Car>> fetchLatestCar(int pageNumber) async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.apiUrl}/api/car-rent?pageNumber=$pageNumber'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Car> latestCar =
            jsonData.map((json) => Car.fromJson(json)).toList();
        return latestCar;
      } else {
        showToast('Failed to latest car');
        throw Exception('Failed to load latest car');
      }
    } catch (e) {
      showToast('Server Error');
      throw Exception('Server Error');
    }
  }

  Future<List<Car>> fetchCarCategory(int pageNumber, String categoryId) async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.apiUrl}/api/car-rent?pageNumberCat=$pageNumber&category=$categoryId'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Car> latestPromo =
            jsonData.map((json) => Car.fromJson(json)).toList();
        return latestPromo;
      } else {
        showToast('Failed to category cars');
        throw Exception('Failed to load category car');
      }
    } catch (e) {
      showToast('Server Error');
      throw Exception('Server Error');
    }
  }

  Future<CarDetails> fetchOneCar(String carId) async {
    try {
      final response = await http
          .get(Uri.parse('${ApiEndpoints.apiUrl}/api/car-rent/$carId'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        CarDetails carDetails = CarDetails.fromJson(jsonData);
        return carDetails;
      } else {
        showToast('Failed to car details');
        throw Exception('Failed to load data.');
      }
    } catch (e) {
      showToast('Server Error');
      throw Exception('Server Error $e');
    }
  }

  Future<List<Car>> fetchCompanyCars(
      String companyId, int pageNumber, int carPerPage) async {
    try {
      final response = await http.get(Uri.parse(
          '${ApiEndpoints.apiUrl}/api/car-rent?company=$companyId&companyPageNumber=$pageNumber&companyLimitPage=$carPerPage'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Car> companyCar =
            jsonData.map((json) => Car.fromJson(json)).toList();
        return companyCar;
      } else {
        showToast('Failed to cars');
        throw Exception('Failed to load data.');
      }
    } catch (e) {
      showToast('Server Error');
      throw Exception(e);
    }
  }

  Future<List<Car>> fetchTopRated(int pageNumber, int carPerPage) async {
    try {
      final response = await http
          .get(Uri.parse('${ApiEndpoints.apiUrl}/api/car-rent?topRated=1&TopRatedPageNumber=$pageNumber&TopRatedLimitPage=$carPerPage'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<Car> topRatedCar =
            jsonData.map((json) => Car.fromJson(json)).toList();
        return topRatedCar;
      } else {
        showToast('Failed to cars');
        throw Exception('Failed to load data.');
      }
    } catch (e) {
      showToast('Server Error');
      throw Exception(e);
    }
  }
}
