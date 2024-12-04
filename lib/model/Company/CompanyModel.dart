import 'ImageCompanyModel.dart';

class Company {
  final String id;
  final String companyName;
  final String companyEmail;
  final String companyPhoneNumber;
  final String companyAddress;
  final String companyCity;
  final String companyState;
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
    required this.companyState,
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
      companyAddress: json['CompanyAddress'] ?? '',
      companyCity: json['CompanyCity'] ?? '',
      companyState: json['CompanyState'] ?? '',
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
