import 'package:carrent/Api/CarService.dart';
import 'package:carrent/model/Car/CarModel.dart';
import 'package:carrent/model/CarDetails/CarDetailsModel.dart';
import 'package:flutter/foundation.dart';

class CarProvider with ChangeNotifier {
  CarService car = CarService();

  List<Car> _latestCar = [];
  List<Car> get latestCar => _latestCar;
  getLatestCar() async {
    final res = await car.fetchLatestCar(1);
    _latestCar = res;
    notifyListeners();
  }

  List<Car> _categoryCar = [];
  List<Car> get categoryCar => _categoryCar;
  getCategoryCar(int pageNumber, String categoryId) async {
    final res = await car.fetchCarCategory(pageNumber, categoryId);
    _categoryCar = res;
    notifyListeners();
  }

  CarDetails? _carDetails;
  CarDetails? get carDetails => _carDetails;
  getCarDetails(String carId) async {
    final res = await car.fetchOneCar(carId);
    _carDetails = res;
    notifyListeners();
  }
}
