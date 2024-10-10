
import 'package:carrent/model/User/UserModel.dart';

class Review {
  final String id;
  final String userId;
  final String carId;
  final int rate;
  final String reviewText;
  final String createdAt;
  final String updatedAt;
  final User? userDetails;

  Review({
    required this.id,
    required this.userId,
    required this.carId,
    required this.rate,
    required this.reviewText,
    required this.createdAt,
    required this.updatedAt,
    this.userDetails
  });

  factory Review.fromJson(Map<String,dynamic> json){
    return Review(
      id: json['_id'] ?? "",
      userId: json['userId'] ?? "",
      carId: json['carId'] ?? "",
      rate: json['rate'] ?? 0,
      reviewText: json['reviewText'] ?? "", 
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
      userDetails: json['user'] != null ? User.fromJson(json['user']) : null
    );
  }
}