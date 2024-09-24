
class ImageCompanyDetails {
  final String url;
  final String cloudinaryId;

  ImageCompanyDetails({
    required this.url,
    required this.cloudinaryId,
  });

  factory ImageCompanyDetails.fromJson(Map<String, dynamic> json) {
    return ImageCompanyDetails(
      url: json['url'] ?? '',
      cloudinaryId: json['cloudinary_id'] ?? '',
    );
  }
}
