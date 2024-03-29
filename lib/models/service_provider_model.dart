class ServiceProvider {
 final String name;
  final String photo;
  final String? gstNumber;
  final String aadharCard;
  final String experience;
  final String location;
  final String? email;
  final String panCard;
  final String phoneNumber;
  final num wallet;
  final String rating;
  List<Services>? services;
  final num totalServices;
  final String? aadharCardPhoto;
  final String uid;
  final num latitude;
  final bool isGoogleUser;
  final num longitude;
  final String deviceToken;
  final String referralCode;
  final num totalEarnings;

  ServiceProvider(
      { this.gstNumber,
    required this.wallet,
    required this.aadharCard,
    required this.experience,
    required this.location,
    required this.referralCode,
    this.email,
    required this.name,
    this.aadharCardPhoto,
    required this.uid,
    required this.panCard,
    required this.isGoogleUser,
    required this.phoneNumber,
    required this.photo,
    required this.rating,
    this.services,
    required this.totalServices,
    required this.latitude,
    required this.deviceToken,
    required this.longitude,
    required this.totalEarnings});

  factory ServiceProvider.fromMap(Map<String, dynamic> map) {
    return ServiceProvider(
 gstNumber: map['GSTNumber'] ?? "none",
        aadharCardPhoto: map['aadharCardPhoto'] ?? "",
        wallet: map['wallet'] ?? 0,
        email: map['email'] ?? "none",
        aadharCard: map['aadharCard'] ?? "",
        experience: map['experience'] ?? "",
        location: map['location'] ?? "",
        referralCode: map['referralCode'] ?? "",
        name: map['name'] ?? "",
        uid: map['uid'] ?? "",
        isGoogleUser: map['isGoogleUser'] ?? false,
        panCard: map['panCard'] ?? "",
        phoneNumber: map['phoneNumber'] ?? "",
        photo: map['photo'] ?? "",
        latitude: map['latitude'] ?? 0,
        rating: map['rating'] ?? "",
        deviceToken: map['deviceToken'] ?? "",
        longitude: map['longitude'] ?? 0,
           services: (map['services'] as List<dynamic>)
                .map((serviceCategories) => Services.fromMap(serviceCategories))
                .toList() ??
            [],
        totalServices: map['totalServices'] ?? "",
        totalEarnings:map['totalEarnings']?? 0);
  
  }
}

class Services {
  final String serviceModelName;
  final String serviceModelUID;
  final String? serviceName;
  final String? serviceUID;
  final List<SubService>? subServiceCategories;

  Services({
    required this.serviceModelName,
    required this.serviceModelUID,
    this.serviceName,
     this.serviceUID,
     this.subServiceCategories,
  });

  factory Services.fromMap(Map<String, dynamic> map) {
    List<SubService> subServices = [];
    if (map['subServiceCategories'] != null) {
      var subServiceList = map['subServiceCategories'] as List;
      subServices = subServiceList
          .map((subServiceJson) => SubService.fromMap(subServiceJson))
          .toList();
    }
    return Services(
      serviceModelName: map['serviceModelName'],
      serviceModelUID: map['serviceModelUID'],
      serviceName: map['serviceName'] ?? "",
      serviceUID: map['serviceUID'] ?? "",
      subServiceCategories: subServices ?? [],
    );
  }
}

class SubService {
  final String subCategoryServiceName;
  final String serviceCategoryUID;
  final String subCategoryServiceUID;
  final List<String> customerReviews;
  final String rate;

  SubService({
    required this.subCategoryServiceName,
    required this.serviceCategoryUID,
    required this.subCategoryServiceUID,
    required this.customerReviews,
    required this.rate,
  });

  factory SubService.fromMap(Map<String, dynamic> map) {
    List<String> reviews = [];
    if (map['customerReviews'] != null) {
      var reviewList = map['customerReviews'] as List;
      reviews = reviewList.map((review) => review.toString()).toList();
    }
    return SubService(
      subCategoryServiceName: map['subCategoryServiceName'],
      serviceCategoryUID: map['serviceCategoryUID'],
      subCategoryServiceUID: map['subCategoryServiceUID'],
      customerReviews: reviews,
      rate: map['rate'],
    );
  }
}


class CustomerReview {
  final String customerName;
  final String customerOrderId;
  final String customerRating;
  final String customerReview;
  final String customerUID;

  CustomerReview({
    required this.customerName,
    required this.customerOrderId,
    required this.customerRating,
    required this.customerReview,
    required this.customerUID,
  });

  factory CustomerReview.fromMap(Map<String, dynamic> map) {
    return CustomerReview(
      customerName: map['customerName'],
      customerOrderId: map['customerOrderId'],
      customerRating: map['customerRating'],
      customerReview: map['customerReview'],
      customerUID: map['customerUID'],
    );
  }
}
