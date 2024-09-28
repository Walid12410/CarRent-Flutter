class Category {
  final String id;
  final String categoryName;
  final String createdAt;
  final String updatedAt;

  Category(
      {required this.id,
      required this.categoryName,
      required this.createdAt,
      required this.updatedAt});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? '',
      categoryName: json['categoryName'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
