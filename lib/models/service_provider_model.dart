import 'package:meta/meta.dart';

class ServiceProvider {
  final String gstNumber;
  final String aadharCard;
  final String experience;
  final String location;
  final String name;
  final String panCard;
  final num phoneNumber;
  final String photo;
  final String rating;
  final List<Review> reviews;
  final List<ServiceCategories> serviceCategories;
  final List<ServiceSubCategories> serviceSubCategories;
  final String serviceType;
  final String totalServices;
  final String uid;
    final num latitude;
  final num longitude;

  ServiceProvider({
    required this.gstNumber,
    required this.aadharCard,
    required this.experience,
    required this.location,
    required this.name,
    required this.uid,
    required this.panCard,
    required this.phoneNumber,
    required this.photo,
    required this.rating,
    required this.reviews,
    required this.serviceCategories,
    required this.serviceSubCategories,
    required this.serviceType,
    required this.totalServices,
     required this.latitude,
      required this.longitude});

  factory ServiceProvider.fromMap(Map<String, dynamic> map) {
    return ServiceProvider(
      gstNumber: map['GSTNumber'],
      aadharCard: map['aadharCard'],
      experience: map['experience'],
      location: map['location'],
      name: map['name'],
      uid: map['uid'],
      panCard: map['panCard'],
      phoneNumber: map['phoneNumber'],
      photo: map['photo'],
      latitude: map['latitude'] ?? 0,
      rating: map['rating'],
            longitude: map['longitude'] ?? 0,
      reviews: (map['reviews'] as List<dynamic>)
          .map((review) => Review.fromMap(review))
          .toList(),
      serviceCategories: (map['serviceCategories'] as List<dynamic>)
          .map((serviceCategories) =>
              ServiceCategories.fromMap(serviceCategories))
          .toList(),
      serviceSubCategories: (map['serviceSubCategories'] as List<dynamic>)
          .map((serviceSubCategories) =>
              ServiceSubCategories.fromMap(serviceSubCategories))
          .toList(),
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

class ServiceCategories {
  final String serviceCategory;
  final String serviceCategoryUID;

  ServiceCategories({
    required this.serviceCategory,
    required this.serviceCategoryUID,
  });

  factory ServiceCategories.fromMap(Map<String, dynamic> map) {
    return ServiceCategories(
      serviceCategory: map['serviceCategory'],
      serviceCategoryUID: map['serviceCategoryUID'],
    );
  }
}

class ServiceSubCategories {
  final num subServiceCategoryRate;
  final String subServiceCategoryUID;
    final String serviceCategoryUID;

  final List<SubServiceCategoryReviews>? subServiceCategoryReviews;
  ServiceSubCategories({
    required this.subServiceCategoryRate,
    required this.subServiceCategoryUID,
    required this.serviceCategoryUID,
    this.subServiceCategoryReviews,
  });

  factory ServiceSubCategories.fromMap(Map<String, dynamic> map) {
    return ServiceSubCategories(
      subServiceCategoryRate: map['subServiceCategoryRate'],
      subServiceCategoryUID: map['subServiceCategoryUID'],
      serviceCategoryUID: map['serviceCategoryUID'],
      subServiceCategoryReviews:
          (map['subServiceCategoryReviews'] as List<dynamic>)
              .map((review) => SubServiceCategoryReviews.fromMap(review))
              .toList(),
    );
  }
}

class SubServiceCategoryReviews {
  final String customerName;
  final String customerRating;
  final String customerReview;
  final String customerOrderId;
  final String customerUID;

  SubServiceCategoryReviews(
      {required this.customerName,
      required this.customerRating,
      required this.customerReview,
      required this.customerOrderId,
      required this.customerUID});

  factory SubServiceCategoryReviews.fromMap(Map<String, dynamic> map) {
    return SubServiceCategoryReviews(
        customerName: map['CustomerName'],
        customerRating: map['CustomerRating'],
        customerReview: map['CustomerReview'],
        customerOrderId: map['CustomerOrderId'],
        customerUID: map['CustomerUID']);
  }
}
