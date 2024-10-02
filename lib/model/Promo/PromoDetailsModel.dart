import 'package:carrent/model/Company/CompanyModel.dart';
import 'package:carrent/model/Promo/PromoImageModel.dart';

class PromoDetails {
  final String id;
  final String promoCode;
  final int discountAmount;
  final int discountPercentage;
  final DateTime startDate;
  final DateTime endDate;
  final int usageLimit;
  final int usedCount;
  final String status;
  final String promoTitle;
  final String promoDescription;
  final PromoImage promoImage;
  final Company? companyDetails;

  PromoDetails({
    required this.id,
    required this.promoCode,
    required this.discountAmount,
    required this.discountPercentage,
    required this.startDate,
    required this.endDate,
    required this.usageLimit,
    required this.usedCount,
    required this.status,
    required this.promoTitle,
    required this.promoDescription,
    required this.promoImage,
    required this.companyDetails,
  });

   PromoDetails.fromJson(Map<String, dynamic> json) {
      id = json['_id'] ?? '' ;
      promoCode: json['promoCode'] ?? '',
      discountAmount: json['discountAmount'] ?? 0,
      discountPercentage: json['discountPercentage'] ?? 0,
      startDate: DateTime.parse(json['startDate'] ?? DateTime.now().toIso8601String()),
      endDate: DateTime.parse(json['endDate'] ?? DateTime.now().toIso8601String()),
      usageLimit: json['usageLimit'] ?? 0,
      usedCount: json['usedCount'] ?? 0,
      status: json['status'] ?? '',
      promoTitle: json['promoTitle'] ?? '',
      promoDescription: json['promoDescription'] ?? '',
      promoImage: PromoImage.fromJson(json['promoImage'] ?? {}),
      companyDetails: (json['comapanyDetails'] != null && (json['comapanyDetails'] as List).isNotEmpty)
          ? Company.fromJson(json['comapanyDetails'][0])
          : null,
  }
}
