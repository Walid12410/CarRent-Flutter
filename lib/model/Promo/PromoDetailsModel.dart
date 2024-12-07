import 'package:carrent/model/Company/CompanyModel.dart';
import 'package:carrent/model/Promo/PromoImageModel.dart';

class PromoDetails {
  final String id;
  final String promoCode;
  final int discountPercentage;
  final DateTime startDate;
  final DateTime endDate;
  final int usageLimit;
  final int usedCount;
  final String status;
  final String promoTitle;
  final String promoDescription;
  final PromoImage promoImage;
  final Company? company;

  PromoDetails(
      {required this.id,
      required this.promoCode,
      required this.discountPercentage,
      required this.startDate,
      required this.endDate,
      required this.usageLimit,
      required this.usedCount,
      required this.status,
      required this.promoTitle,
      required this.promoDescription,
      required this.promoImage,
      required this.company});

  factory PromoDetails.fromJson(Map<String, dynamic> json) {
    return PromoDetails(
      id: json['_id'] ?? '',
      promoCode: json['promoCode'] ?? '',
      discountPercentage: json['discountPercentage'] ?? 0,
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : DateTime.now(),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'])
          : DateTime.now(),
      usageLimit: json['usageLimit'] ?? 0,
      usedCount: json['usedCount'] ?? 0,
      status: json['status'] ?? '',
      promoTitle: json['promoTitle'] ?? '',
      promoDescription: json['promoDescription'] ?? '',
      promoImage: PromoImage.fromJson(json['promoImage'] ?? {}),
      company: json['Company'] != null
          ? (json['Company'] is List && (json['Company'] as List).isNotEmpty
              ? Company.fromJson((json['Company'] as List).first)
              : Company.fromJson(json['Company']))
          : null,
    );
  }
}
