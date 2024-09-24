import '../Car/CarModel.dart';

class Offer {

  final String id;
  final String carId;
  final String offerTitle;
  final String startDate;
  final String endDate;
  final String discountPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Car? car;

  Offer({
    required this.id,
    required this.carId,
    required this.offerTitle,
    required this.startDate,
    required this.endDate,
    required this.discountPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.car
  });

  factory Offer.fromJson(Map<String, dynamic>json){
    return Offer(
        id: json['_id'] ?? "",
        carId: json['carId'] ?? "",
        offerTitle: json['offerTitle'] ?? "",
        startDate: json['startDate'] ?? "",
        endDate: json['endDate'] ?? "",
        discountPrice: json['discountPrice'],
        createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
        car: json['car'] !=null ? Car.fromJson(json['car']) : null
    );
  }

}