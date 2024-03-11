class User {
  final String deviceToken;
  final String displayName;
  final String email;
  final String photoURL;
  final String referralCode;
  final String status;
  final String uid;
  final String type;
  final bool isGoogleUser;
  final num wallet;
  final String dob;
  final String location;
  final List? myOrders;
  final num latitude;
  final num longitude;
  final List<MyCart>? myCart;

  User(
      {required this.deviceToken,
      required this.displayName,
      required this.email,
      required this.isGoogleUser,
      required this.photoURL,
      required this.referralCode,
      required this.status,
      required this.uid,
      this.myCart,
      required this.type,
      required this.wallet,
      required this.location,
      required this.dob,
      required this.myOrders,
      required this.latitude,
      required this.longitude});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      deviceToken: map['deviceToken'] ?? '',
      displayName: map['name'] ?? '',
      email: map['email'] ?? '',
      isGoogleUser: map['isGoogleUser'] ?? false,
      photoURL: map['photo'] ?? '',
      referralCode: map['referralCode'] ?? '',
      status: map['status'] ?? '',
      uid: map['uid'] ?? '',
      dob: map['DOB'] ?? "",
      wallet: map['wallet'] ?? "",
      type: map['type'] ?? "",
      myCart: (map['myCart'] as List<dynamic>?)
          ?.map((item) => MyCart.fromMap(item))
          .toList(),
      location: map['location'] ?? "",
      latitude: map['latitude'] ?? 0,
      longitude: map['longitude'] ?? 0,
      myOrders: List<String>.from(map['myOrders'] ?? []),
    );
  }
}

class MyCart {
  final num cost;
  final String serviceCategoryName;
  final String subCategoryServiceUID;
  final String serviceCategoryUID;
  final String serviceProviderName;
  final String serviceProviderPhoto;
  final String serviceProviderUID;
  final String subCategoryServiceName;
  MyCart(
      {required this.cost,
      required this.subCategoryServiceUID,
      required this.serviceCategoryName,
      required this.serviceCategoryUID,
      required this.serviceProviderName,
      required this.serviceProviderPhoto,
      required this.serviceProviderUID,
      required this.subCategoryServiceName});
  Map<String, dynamic> toMap() {
    return {
      'serviceCategoryName': serviceCategoryName,
      'subCategoryServiceName': subCategoryServiceName,
      'subCategoryServiceUID': subCategoryServiceUID,
      'serviceCategoryUID': serviceCategoryUID,
      'serviceProviderName': serviceProviderName,
      'serviceProviderPhoto': serviceProviderPhoto,
      'serviceProviderUID': serviceProviderUID,
      'cost': cost
    };
  }

  factory MyCart.fromMap(Map<String, dynamic> map) {
    return MyCart(
        serviceCategoryName: map['serviceCategoryName'],
        cost: map['cost'],
        subCategoryServiceUID: map['subCategoryServiceUID'],
        serviceCategoryUID: map['serviceCategoryUID'],
        serviceProviderPhoto: map['serviceProviderPhoto'],
        serviceProviderUID: map['serviceProviderUID'],
        serviceProviderName: map['serviceProviderName'],
        subCategoryServiceName: map['subCategoryServiceName']);
  }
}
