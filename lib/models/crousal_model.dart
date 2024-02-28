class Carousal {
  final String bannerImage;


  Carousal(
      {required this.bannerImage,

     });

  factory Carousal.fromMap(Map<String, dynamic> map) {
    return Carousal(
        bannerImage: map['bannerImage'] ?? "",

    );
  }
}
