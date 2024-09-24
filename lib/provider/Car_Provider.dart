import 'package:carrent/Api/CarService.dart';
import 'package:carrent/model/Car/CarModel.dart';
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


}