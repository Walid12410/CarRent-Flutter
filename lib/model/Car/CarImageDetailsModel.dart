class ImageDetails {
  final String url;
  final String cloudinaryId;

  ImageDetails({
    required this.url,
    required this.cloudinaryId,
  });

  factory ImageDetails.fromJson(Map<String, dynamic> json) {
    return ImageDetails(
      url: json['url'] ?? '',
      cloudinaryId: json['cloudinary_id'] ?? '',
    );
  }
}
