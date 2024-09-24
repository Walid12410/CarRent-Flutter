import 'ImageCompanyDetailsModel.dart';

class ImageCompany {
  final ImageCompanyDetails image;
  final String id;
  final String companyID;
  final bool isDefaultImage;
  final DateTime createdAt;
  final DateTime updatedAt;

  ImageCompany({
    required this.image,
    required this.id,
    required this.companyID,
    required this.isDefaultImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ImageCompany.fromJson(Map<String, dynamic> json) {
    return ImageCompany(
      image: ImageCompanyDetails.fromJson(json['image'] ?? {}),
      id: json['_id'] ?? '',
      companyID: json['companyID'] ?? '',
      isDefaultImage: json['isDefaultImage'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}
