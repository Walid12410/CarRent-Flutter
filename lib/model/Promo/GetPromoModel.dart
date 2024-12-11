class GetPromo {
  final String id;
  final String userId;
  final String promoId;
  final String claimedAt;
  final bool isUsed;
  final String startDate;
  final String endDate;
  final String createdAt;
  final String updatedAt;

  GetPromo({
    required this.id,
    required this.userId,
    required this.promoId,
    required this.claimedAt,
    required this.isUsed,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetPromo.fromJson(Map<String, dynamic> json) {
    return GetPromo(
      id: json['_id'] ?? "",
      userId: json['userId'] ?? "",
      promoId: json['promoId'] ?? "",
      claimedAt: json['claimedAt'] ?? "",
      isUsed: json['isUsed'] ?? false,
      startDate: json['startDate'] ?? "",
      endDate: json['endDate'] ?? "",
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
    );
  }
}
