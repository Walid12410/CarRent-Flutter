import 'package:carrent/model/Car/CarModel.dart';

class Feature {
  final String id;
  final String carId;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Car? car;

  Feature({
    required this.id,
    required this.carId,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.car,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      id: json['_id'] ?? "",
      carId: json['carId'] ?? "",
      startDate:
          DateTime.parse(json['startDate'] ?? DateTime.now().toIso8601String()),
      endDate:
          DateTime.parse(json['endDate'] ?? DateTime.now().toIso8601String()),
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      car: json['car'] != null ? Car.fromJson(json['car']) : null,
    );
  }
}
