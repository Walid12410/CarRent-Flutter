

import 'package:carrent/model/Car/CarModel.dart';

class Booking {
  final String id;
  final String userId;
  final String carId;
  final int daysRent;
  final String promoCode;
  final int discountPercent;
  final double mainCarPrice;
  final double totalRentPrice;
  final String startDate;
  final String endDate;
  final String createdAt;
  final String updatedAt;
  final Car? car;

  Booking({
    required this.id,
    required this.userId,
    required this.carId,
    required this.daysRent,
    required this.promoCode,
    required this.discountPercent,
    required this.mainCarPrice,
    required this.totalRentPrice,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.car
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      carId: json['carId'] ?? '',
      daysRent: json['daysRent'] ?? 0,
      promoCode: json['promoCode'] ?? '',
      discountPercent: json['discountPercent'] ?? 0,
      mainCarPrice: (json['mainCarPrice'] ?? 0).toDouble(),
      totalRentPrice: (json['totalRentPrice'] ?? 0).toDouble(),
      startDate: json['startDate'] ?? "",
      endDate: json['endDate'] ?? "",
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
      car: json['car'] != null
          ? (json['car'] is List &&
                  (json['car'] as List).isNotEmpty
              ? Car.fromJson((json['car'] as List).first)
              : Car.fromJson(json['car']))
          : null,
    );
  }
}