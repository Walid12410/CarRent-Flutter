import 'ImageCompanyModel.dart';

class Company {
  final String id;
  final String companyName;
  final String companyEmail;
  final String companyPhoneNumber;
  final String companyCountry;
  final String companyCity;
  final String companyAddress;
  final double longitude;
  final double latitude;
  final int carCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ImageCompany>? imageCompany;

  Company({
    required this.id,
    required this.companyName,
    required this.companyEmail,
    required this.companyPhoneNumber,
    required this.companyAddress,
    required this.companyCity,
    required this.companyCountry,
    required this.longitude,
    required this.latitude,
    required this.carCount,
    required this.createdAt,
    required this.updatedAt,
    this.imageCompany,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['_id'] ?? '',
      companyName: json['companyName'] ?? '',
      companyEmail: json['companyEmail'] ?? '',
      companyPhoneNumber: json['CompanyPhoneNumber'] ?? '',
      companyAddress: json['address'] ?? '',
      companyCity: json['city'] ?? '',
      companyCountry: json['country'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      carCount: json['carCount'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      imageCompany: (json['imageCompany'] as List<dynamic>?)
              ?.map((imageJson) => ImageCompany.fromJson(imageJson))
              .toList() ?? [],
    );
  }
}
