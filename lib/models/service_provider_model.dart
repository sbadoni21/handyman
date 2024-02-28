class ServiceProvider {
  final String gstNumber;
  final String aadharCard;
  final String experience;
  final String location;
  final String name;
  final String panCard;
  final int phoneNumber;
  final String photo;
  final String rating;
  final List<Review> reviews;
  final String serviceCategory;
  final int serviceCharge;
  final String serviceType;
  final String totalServices;

  ServiceProvider({
    required this.gstNumber,
    required this.aadharCard,
    required this.experience,
    required this.location,
    required this.name,
    required this.panCard,
    required this.phoneNumber,
    required this.photo,
    required this.rating,
    required this.reviews,
    required this.serviceCategory,
    required this.serviceCharge,
    required this.serviceType,
    required this.totalServices,
  });

  factory ServiceProvider.fromMap(Map<String, dynamic> map) {
    return ServiceProvider(
      gstNumber: map['GSTNumber'],
      aadharCard: map['aadharCard'],
      experience: map['experience'],
      location: map['location'],
      name: map['name'],
      panCard: map['panCard'],
      phoneNumber: map['phoneNumber'],
      photo: map['photo'],
      rating: map['rating'],
      reviews: (map['reviews'] as List<dynamic>)
          .map((review) => Review.fromMap(review))
          .toList(),
      serviceCategory: map['serviceCategory'],
      serviceCharge: map['serviceCharge'],
      serviceType: map['serviceType'],
      totalServices: map['totalServices'],
    );
  }
}

class Review {
  final String customerName;
  final String customerRating;
  final String customerReview;

  Review({
    required this.customerName,
    required this.customerRating,
    required this.customerReview,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      customerName: map['customerName'],
      customerRating: map['customerRating'],
      customerReview: map['customerReview'],
    );
  }
}
