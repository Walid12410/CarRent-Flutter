import 'PromoImageModel.dart';

class Promo {
  final String id;
  final String promoCode;
  final int discountPercentage;
  final DateTime startDate;
  final DateTime endDate;
  final int usageLimit;
  final int usedCount;
  final String status;
  final String companyID;
  final String promoTitle;
  final String promoDescription;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PromoImage promoImage;

  Promo({
    required this.id,
    required this.promoCode,
    required this.discountPercentage,
    required this.startDate,
    required this.endDate,
    required this.usageLimit,
    required this.usedCount,
    required this.status,
    required this.companyID,
    required this.promoTitle,
    required this.promoDescription,
    required this.createdAt,
    required this.updatedAt,
    required this.promoImage, // Add this line
  });

  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
      id: json['_id'] ?? '',
      promoCode: json['promoCode'] ?? '',
      discountPercentage: json['discountPercentage'] ?? 0,
      startDate: DateTime.parse(json['startDate'] ?? DateTime.now().toIso8601String()),
      endDate: DateTime.parse(json['endDate'] ?? DateTime.now().toIso8601String()),
      usageLimit: json['usageLimit'] ?? 0,
      usedCount: json['usedCount'] ?? 0,
      status: json['status'] ?? '',
      companyID: json['companyId'] ?? '',
      promoTitle: json['promoTitle'] ?? '',
      promoDescription: json['promoDescription'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      promoImage: PromoImage.fromJson(json['promoImage'] ?? {}), // Add this line
    );
  }
}
