import 'package:carrent/model/User/UserPhotoModel.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final UserPhoto? photo;
  final String phoneNumber;
  final bool isAdmin;
  double? latitude;
  double? longitude;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.photo,
    required this.phoneNumber,
    required this.isAdmin,
    this.latitude,
    this.longitude,
    required this.createdAt,
    required this.updatedAt
  });

  factory User.fromJson(Map<String,dynamic> json){
    return User(
      id: json['_id'] ?? "",
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      email: json['email'] ?? "",
      photo: json['profilePhoto'] != null ? UserPhoto.fromJson(json['profilePhoto']) : null,
      phoneNumber: json['phoneNumber'] ?? '',
      isAdmin: json['isAdmin'] ?? false,
      createdAt: json['createdAt'] ?? "", 
      updatedAt: json['updatedAt'] ?? "",
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble()
    );
  }
}