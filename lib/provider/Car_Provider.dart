import 'package:carrent/Api/CarService.dart';
import 'package:carrent/model/Car/CarModel.dart';
import 'package:carrent/model/CarDetails/CarDetailsModel.dart';
import 'package:flutter/foundation.dart';

class CarProvider with ChangeNotifier {
  CarService service = CarService();

  List<Car> _latestCar = [];
  List<Car> get latestCar => _latestCar;
  getLatestCar() async {
    final res = await service.fetchLatestCar(1);
    _latestCar = res;
    notifyListeners();
  }

  List<Car> _categoryCar = [];
  List<Car> get categoryCar => _categoryCar;
  getCategoryCar(int pageNumber, String categoryId) async {
    final res = await service.fetchCarCategory(pageNumber, categoryId,5);
    _categoryCar = res;
    print(_categoryCar.length);
    notifyListeners();
  }

  // Car details
  CarDetails? _carDetails;
  CarDetails? get carDetails => _carDetails;
  getCarDetails(String carId) async {
    final res = await service.fetchOneCar(carId);
    _carDetails = res;
    notifyListeners();
  }

  // latest compamy car
  List<Car> _latestCompanyCar = [];
  List<Car> get latestCompanyCar => _latestCompanyCar;
  getLatestCompanyCar(String companyId, int pageNumber) async {
    final res = await service.fetchCompanyCars(companyId, pageNumber, 5);
    _latestCompanyCar = res;
    notifyListeners();
  }

  // toprated car
  List<Car> _topRatedCar = [];
  List<Car> get topRatedCar => _topRatedCar;
  getTopRatedCar(int pageNumber, int carPerPage) async {
    final res = await service.fetchTopRated(pageNumber, carPerPage);
    _topRatedCar = res;
    notifyListeners();
  }



  // Company Car pagination
  final List<Car> _cars = [];
  bool _isLoading = false;
  int _currentPage = 2;
  final int _perPage = 5;
  bool _hasMoreData = true;

  List<Car> get cars => _cars;
  bool get isLoading => _isLoading;
  bool get hasMoreData => _hasMoreData;

  Future<void> fetchCars(String companyId) async {
    if (_isLoading || !_hasMoreData) return;
    _isLoading = true;
    notifyListeners();

    try {
      List<Car> newCars =
          await service.fetchCompanyCars(companyId, _currentPage, 5);
      if (newCars.length < _perPage) {
        _hasMoreData = false;
      } else {
        _currentPage++;
      }
      for (var car in newCars) {
        if (!_cars.any((existingCar) => existingCar.id == car.id)) {
          _cars.add(car);
        }
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetCompanyCar() {
    _cars.clear();
    _currentPage = 2;
    _hasMoreData = true;
    notifyListeners();
  }



  // Category Car pagination
  final List<Car> _categoryCars = [];
  bool _isLoadingCatCar = false;
  int _currentPageCatCar = 2;
  final int _catCarPerPage = 5;
  bool _catCarHasMoreData = true;

  List<Car> get categoryCars => _categoryCars;
  bool get isLoadingCatCar => _isLoadingCatCar;
  bool get catCarHasMoreData => _catCarHasMoreData;

  Future<void> fetchCategoryCar(String categoryId) async {
    if (_isLoadingCatCar || !_catCarHasMoreData) return;
    _isLoadingCatCar = true;
    notifyListeners();

    try {
      List<Car> newCars =
          await service.fetchCarCategory(_currentPageCatCar, categoryId, _catCarPerPage);
      if (newCars.length < _catCarPerPage) {
        _catCarHasMoreData = false;
      } else {
        _currentPageCatCar++;
      }
      for (var car in newCars) {
        if (!_categoryCars.any((existingCar) => existingCar.id == car.id)) {
          _categoryCars.add(car);
        }
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      _isLoadingCatCar = false;
      notifyListeners();
    }
  }

  void restCarCategory() {
    _categoryCars.clear();
    _currentPageCatCar = 2;
    _catCarHasMoreData = true;
  }

}