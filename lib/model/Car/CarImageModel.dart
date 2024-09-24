
import 'CarImageDetailsModel.dart';

class CarImage {
  final String id;
  final String carRentID;
  final ImageDetails carImage;

  CarImage({
    required this.id,
    required this.carRentID,
    required this.carImage,
  });

  factory CarImage.fromJson(Map<String, dynamic> json) {
    return CarImage(
      id: json['_id'] ?? '',
      carRentID: json['carRentID'] ?? '',
      carImage: ImageDetails.fromJson(json['carImage'] ?? {}),
    );
  }
}
