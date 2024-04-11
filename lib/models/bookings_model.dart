import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handyman/models/time_slots_model.dart';

class BookingModel {
  final num distance;
  final num providerLatitude;
  final String providerLocation;
  final num providerLongitude;
  final String deviceTokenCustomer;
  final String deviceTokenProvider;
  final TimeSlots timeSlot;
  String review;
  final String serviceCost;
  final String serviceLocation;
  final num serviceLocationLatitude;
  final num serviceLocationLongitude;
  final String serviceName;
  final String servicePoviderUID;
  final String serviceProviderName;
  final String serviceSubCategoryName;
  final Timestamp timeOfBooking;
  final String status;
  final String bookingUID;
  BookingModel(
      {required this.distance,
      required this.deviceTokenProvider,
      required this.providerLatitude,
      required this.providerLocation,
      required this.providerLongitude,
      required this.deviceTokenCustomer,
      required this.timeSlot,
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
      required this.status,
      required this.bookingUID});

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
        distance: map['distance'] ?? 0.0,
        timeSlot: TimeSlots.fromMap(map['timeSlot']),
        deviceTokenProvider: map['deviceTokenProvider'],
        deviceTokenCustomer: map['deviceToken'],
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
        bookingUID: map['bookingUID'],
        status: map['status']);
  }

  Map<String, dynamic> toMap() {
    return {
      'distance': distance,
      'providerLatitude': providerLatitude,
      'providerLocation': providerLocation,
      'deviceTokenProvider': deviceTokenProvider,
      'providerLongitude': providerLongitude,
      'review': review,
      'timeSlot':timeSlot,
      'deviceToken': deviceTokenCustomer,
      'serviceCost': serviceCost,
      'serviceLocation': serviceLocation,
      'serviceLocationLatitude': serviceLocationLatitude,
      'serviceLocationLongitude': serviceLocationLongitude,
      'serviceName': serviceName,
      'servicePoviderUID': servicePoviderUID,
      'serviceProviderName': serviceProviderName,
      'serviceSubCategoryName': serviceSubCategoryName,
      'timeOfBooking': timeOfBooking,
      'bookingUID': bookingUID,
      'status': status
    };
  }
}

enum OrderStatus {
  initiated,
  inProgress,
  delivered,
}

class OrderStatusModel {
  final OrderStatus status;
  OrderStatusModel(this.status);
  factory OrderStatusModel.fromString(String statusString) {
    OrderStatus orderStatus;
    switch (statusString.toLowerCase()) {
      case 'initiated':
        orderStatus = OrderStatus.initiated;
        break;
      case 'inProgress':
        orderStatus = OrderStatus.inProgress;
        break;
          case 'delivered':
        orderStatus = OrderStatus.delivered;
        break;
      default:
        throw ArgumentError('Invalid order status: $statusString');
    }

    return OrderStatusModel(orderStatus);
  }

  @override
  String toString() {
    return status.toString().split('.').last;
  }
}
