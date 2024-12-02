import 'package:carrent/model/Car/CarImageModel.dart';
import 'package:carrent/model/Company/CompanyModel.dart';
import 'package:carrent/model/Review/ReviewModel.dart';

class CarDetails {
  final String id;
  final String carMake;
  final String carModel;
  final String year;
  final String color;
  final String carType;
  final String carStatus;
  final String companyId;
  final String licensePlate;
  final String vin;
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
  final Company? company;
  final List<Review>? review;

  CarDetails(
      {required this.id,
      required this.carMake,
      required this.carModel,
      required this.year,
      required this.color,
      required this.carType,
      required this.carStatus,
      required this.companyId,
      required this.licensePlate,
      required this.vin,
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
      required this.company,
      required this.review});

factory CarDetails.fromJson(Map<String, dynamic> json) {
  return CarDetails(
    id: json['_id'] ?? '',
    carMake: json['carMake'] ?? '',
    carModel: json['carModel'] ?? '',
    year: json['year'] ?? '',
    color: json['color'] ?? '',
    carType: json['carType'] ?? '',
    carStatus: json['carStatus'] ?? '',
    companyId: json['companyId'] ?? '',
    licensePlate: json['licensePlate'] ?? '',
    vin: json['vin'] ?? '',
    mileage: json['mileage'] ?? '',
    fuelType: json['fuelType'] ?? '',
    transmission: json['transmission'] ?? '',
    rentPrice: (json['rentPrice'] ?? 0).toDouble(),
    categoryId: json['categoryId'] ?? '',
    createdAt: json['createdAt'] ?? '',
    updatedAt: json['updatedAt'] ?? '',
    reviewCount: json['reviewCount'] ?? 0,
    averageRating: (json['averageRating'] ?? 0).toDouble(),
    carImage: (json['CarImage'] as List<dynamic>?)
            ?.map((imageJson) => CarImage.fromJson(imageJson))
            .toList() ??
        [],
    company: json['companyDetails'] != null
        ? (json['companyDetails'] is List && (json['companyDetails'] as List).isNotEmpty
            ? Company.fromJson((json['companyDetails'] as List).first)
            : Company.fromJson(json['companyDetails']))
        : null,
    review: json['reviews'] != null && (json['reviews'] is List && (json['reviews'] as List).isNotEmpty)
        ? (json['reviews'] as List<dynamic>)
            .map((reviewJson) => Review.fromJson(reviewJson))
            .toList()
        : null,
  );
}

}
