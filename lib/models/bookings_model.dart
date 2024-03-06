import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final num distance;
  final num providerLatitude;
  final String providerLocation;
  final num providerLongitude;
  final String review;
  final String serviceCost;
  final String serviceLocation;
  final num serviceLocationLatitude;
  final num serviceLocationLongitude;
  final String serviceName;
  final String servicePoviderUID;
  final String serviceProviderName;
  final String serviceSubCategoryName;
  final Timestamp timeOfBooking;

  BookingModel({
    required this.distance,
    required this.providerLatitude,
    required this.providerLocation,
    required this.providerLongitude,
    required this.review,
    required this.serviceCost,
    required this.serviceLocation,
    required this.serviceLocationLatitude,
    required this.serviceLocationLongitude,
    required this.serviceName,
    required this.servicePoviderUID,
    required this.serviceProviderName,
    required this.serviceSubCategoryName,
    required this.timeOfBooking,
  });

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      distance: map['distance'] ?? 0.0,
      providerLatitude: map['providerLatitude'] ?? 0.0,
      providerLocation: map['providerLocation'] ?? "",
      providerLongitude: map['providerLongitude'] ?? 0.0,
      review: map['review'] ?? "",
      serviceCost: map['serviceCost'] ?? "",
      serviceLocation: map['serviceLocation'] ?? "",
      serviceLocationLatitude: map['serviceLocationLatitude'] ?? 0.0,
      serviceLocationLongitude: map['serviceLocationLongitude'] ?? 0.0,
      serviceName: map['serviceName'] ?? "",
      servicePoviderUID: map['servicePoviderUID'] ?? "",
      serviceProviderName: map['serviceProviderName'] ?? "",
      serviceSubCategoryName: map['serviceSubCategoryName'] ?? "",
      timeOfBooking: map['timeOfBooking'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'distance': distance,
      'providerLatitude': providerLatitude,
      'providerLocation': providerLocation,
      'providerLongitude': providerLongitude,
      'review': review,
      'serviceCost': serviceCost,
      'serviceLocation': serviceLocation,
      'serviceLocationLatitude': serviceLocationLatitude,
      'serviceLocationLongitude': serviceLocationLongitude,
      'serviceName': serviceName,
      'servicePoviderUID': servicePoviderUID,
      'serviceProviderName': serviceProviderName,
      'serviceSubCategoryName': serviceSubCategoryName,
      'timeOfBooking': timeOfBooking,
    };
  }
}
