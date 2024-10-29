class CarMake {
  final String id;
  final String carMakeName;
  final String createdAt;
  final String updatedAt;

  CarMake({
    required this.id,
    required this.carMakeName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CarMake.fromJson(Map<String, dynamic> json) {
    return CarMake(
      id: json['_id'] ?? "",
      carMakeName: json['carMakeName'] ?? "",
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
    );
  }
}
