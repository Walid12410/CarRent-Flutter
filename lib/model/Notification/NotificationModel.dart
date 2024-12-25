class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String userId;
  final String createdAt;
  final String updatedAt;

  // Constructor
  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create an instance from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? "",
      title: json['title'] ?? "",
      body: json['body'] ?? "",
      userId: json['userId'] ?? "",
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
    );
  }

}
