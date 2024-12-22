import 'dart:convert';
import 'package:carrent/core/ApiEndPoint.dart';
import 'package:carrent/model/Car/CarModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SerachProvider extends ChangeNotifier {
  
  double _currentMinValue = 15.0;
  double _currentMaxValue = 500.0;
  String? _selectedCarMake;
  final List<String> _selectedCategories = [];

  // Add getters for the values
  String? get selectedCarMake => _selectedCarMake;
  List<String> get selectedCategories => _selectedCategories;
  double get currentMinValue => _currentMinValue;
  double get currentMaxValue => _currentMaxValue;
  
  // initialize the values
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _currentMinValue = prefs.getDouble('minValue') ?? 15.0;
    _currentMaxValue = prefs.getDouble('maxValue') ?? 500.0;
    notifyListeners();
  }

  // Add methods for setting values for select category
  Future<void> setCategory(List<String> category) async {
    if(category.isEmpty) {
      _selectedCategories.clear();
    } else {
      _selectedCategories.clear();
      _selectedCategories.addAll(category);
    }
    notifyListeners();
  }

  // Add methods for setting values for select car model
  Future<void> setCarMake(String? carModel) async {
    if(carModel == null) {
      _selectedCarMake = null;
    } else {
      _selectedCarMake = carModel;
    }
    notifyListeners();
  }

  // Add methods for setting values
  Future<void> setPriceRange(double minValue, double maxValue) async {
    _currentMinValue = minValue;
    _currentMaxValue = maxValue;
    notifyListeners();
  }

  // apply filter method save in sharedPreference
  Future<void> applyFilter() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('minValue', _currentMinValue);
    prefs.setDouble('maxValue', _currentMaxValue);
    notifyListeners();
  }

  // clear filter
  Future<void> clearFilter() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('minValue');
    prefs.remove('maxValue');
    _currentMinValue = 15.0;
    _currentMaxValue = 500.0;
    _selectedCategories.clear();
    _selectedCarMake = null;
    notifyListeners();
  }

  // search result method
  List<Car> _cars = [];
  bool _isLoading = false;
  String _error = '';
  int totalResults = 0;

  List<Car> get cars => _cars;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchSearch(int pageNumber, String searchQuery, List<String>? categories,
    double minPrice, double maxPrice, String? carMake) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('${ApiEndpoints.apiUrl}/api/car-rent/search');

    try {
      final body = {
        'page': pageNumber,
        'limit': 10,
        if (categories!.isNotEmpty) 'categoryId': categories,
        'priceMin': minPrice,
        'priceMax': maxPrice,
        if (carMake != null) 'carMakeId': carMake,
        'carModel': searchQuery,
      };


      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['success']) {
          List<dynamic> carsJson = data['date'];
          _cars = carsJson.map((car) => Car.fromJson(car)).toList();
          totalResults = data['total'];
        } else {
          _error = 'No cars found';
        }
      } else {
        _error = 'Failed to fetch data';
      }
    } catch (e) {
      _error = 'Server Error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
