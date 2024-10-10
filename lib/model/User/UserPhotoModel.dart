

class UserPhoto {
  final String url;
  final String publicId;

  UserPhoto({
    required this.url,
    required this.publicId
  });

  factory UserPhoto.fromJson(Map<String,dynamic> json){
    return UserPhoto(
      url: json['url'] ?? "",
       publicId: json['publicId'] ?? ""
    );
  }
}