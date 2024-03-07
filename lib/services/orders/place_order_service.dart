import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:handyman/models/bookings_model.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/models/service_provider_model.dart';
import 'package:random_string/random_string.dart';

class OrderServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addOrder(
      User user, ServiceProvider serviceProvider, String bookingId, num serviceCost, String serviceName, String serviceSubCategoryName) async {
    try {
      Future<double> calculateDistance(
        double startLat,
        double startLng,
        double endLat,
        double endLng,
      ) async {
        try {
          double distance = await Geolocator.distanceBetween(
            startLat,
            startLng,
            endLat,
            endLng,
          );
          return distance / 1000000;
        } catch (e) {
          print("Error calculating distance: $e");
          return 0.0; // Handle errors gracefully
        }
      }

      double distanceFuture = await calculateDistance(
        user!.latitude.toDouble(),
        user.longitude.toDouble(),
        serviceProvider.latitude.toDouble(),
        serviceProvider.longitude.toDouble(),
      );

      Map<String, dynamic> orderData = {
        'distance': distanceFuture,
        'providerLatitude': serviceProvider.latitude,
        'providerLocation': serviceProvider.location,
        'providerLongitude': serviceProvider.longitude,
        'review': '',
        'serviceCost': serviceCost,
        'serviceLocation': user.location,
        'serviceLocationLatitude': user.latitude,
        'serviceLocationLongitude': user.longitude,
        'serviceName': serviceName,
        'servicePoviderUID': serviceProvider.uid,
        'serviceProviderName': serviceProvider.name,
        'serviceSubCategoryName': serviceProvider,
        'timeOfBooking': Timestamp.now(),
        'bookingUID': bookingId,
      };

      await _firestore.collection('orders').add(orderData);
    } catch (e) {
      print('Error adding order: $e');
      throw e;
    }
  }
}
