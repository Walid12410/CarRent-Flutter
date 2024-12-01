import 'package:carrent/model/Car/CarMakeModel.dart';

import 'CarImageModel.dart';

class Car {
  final String id;
  final String carMakeId;
  final String carModel;
  final String year;
  final String color;
  final String carStatus;
  final String companyId;
  final String licensePlate;
  final String mileage;
  final String fuelType;
  final String transmission;
  final double rentPrice;
  final String categoryId;
  final String createdAt;
  final String updatedAt;
  final int reviewCount;
  final double averageRating;
  final List<CarImage> carImage;
  final CarMake carMake;


  Car({
    required this.id,
    required this.carMakeId,
    required this.carModel,
    required this.year,
    required this.color,
    required this.carStatus,
    required this.companyId,
    required this.licensePlate,
    required this.mileage,
    required this.fuelType,
    required this.transmission,
    required this.rentPrice,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.reviewCount,
    required this.averageRating,
    required this.carImage,
    required this.carMake
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['_id'] ?? '',
      carMakeId: json['carMake'] ?? '',
      carModel: json['carModel'] ?? '',
      year: json['year'] ?? '',
      color: json['color'] ?? '',
      carStatus: json['carStatus'] ?? '',
      companyId: json['companyId'] ?? '',
      licensePlate: json['licensePlate'] ?? '',
      mileage: json['mileage'] ?? '',
      fuelType: json['fuelType'] ?? '',
      transmission: json['transmission'] ?? '',
      rentPrice: (json['rentPrice']?? 0).toDouble(),
      categoryId: json['categoryId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      reviewCount: json['reviewCount'] ?? 0,
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      carMake: CarMake.fromJson(json['CarMake'] ?? {}), // Parse CarMake object
      carImage: (json['CarImage'] as List<dynamic>?)
              ?.map((imageJson) => CarImage.fromJson(imageJson))
              .toList() ??
          [],
    );
  }
}
