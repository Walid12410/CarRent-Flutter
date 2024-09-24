import 'ImageCompanyModel.dart';

class Company {
  final String id;
  final String companyName;
  final String companyEmail;
  final String companyPhoneNumber;
  final String companyAddress;
  final String companyCity;
  final String companyState;
  final int carCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ImageCompany? imageCompany;

  Company({
    required this.id,
    required this.companyName,
    required this.companyEmail,
    required this.companyPhoneNumber,
    required this.companyAddress,
    required this.companyCity,
    required this.companyState,
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
      carCount: json['carCount'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      imageCompany: json['imageCompany'] != null ? ImageCompany.fromJson(json['imageCompany']) : null,
    );
  }
}
