class PromoImage {
  final String url;
  final String cloudinaryId;

  PromoImage({
    required this.url,
    required this.cloudinaryId,
  });

  factory PromoImage.fromJson(Map<String, dynamic> json) {
    return PromoImage(
      url: json['url'] ?? '',
      cloudinaryId: json['cloudinary_id'] ?? '',
    );
  }
}
