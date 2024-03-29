import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:handyman/models/bookings_model.dart';
import 'package:handyman/models/service_provider_model.dart';
import 'package:handyman/models/user.dart';

class OrderServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addOrder(
    User user,
    String serviceProviderUID,
    String bookingId,
    String serviceCost,
    String serviceName,
    String serviceSubCategoryName,
  ) async {
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
          return 0.0;
        }
      }

      DocumentSnapshot<Map<String, dynamic>> serviceProviderSnapshot =
          await FirebaseFirestore.instance
              .collection('serviceProviders')
              .doc(serviceProviderUID)
              .get();
      ServiceProvider serviceProvider = ServiceProvider.fromMap(
        serviceProviderSnapshot.data() as Map<String, dynamic>,
      );
      double distanceFuture = await calculateDistance(
        user.latitude.toDouble(),
        user.longitude.toDouble(),
        serviceProvider.latitude.toDouble(),
        serviceProvider.longitude.toDouble(),
      );

      DocumentReference orderRef =
          _firestore.collection('orders').doc(bookingId);
      OrderStatusModel initialOrderStatus =
          OrderStatusModel(OrderStatus.initiated);
      Map<String, dynamic> orderData = {
        'distance': distanceFuture,
        'providerLatitude': serviceProvider.latitude,
        'providerLocation': serviceProvider.location,
        'providerLongitude': serviceProvider.longitude,
        'review': '',
        'status': initialOrderStatus.toString(),
        'serviceCost': serviceCost.toString(),
        'serviceLocation': user.location,
        'serviceLocationLatitude': user.latitude,
        'serviceLocationLongitude': user.longitude,
        'serviceName': serviceName,
        'servicePoviderUID': serviceProvider.uid,
        'serviceProviderName': serviceProvider.name,
        'serviceSubCategoryName': serviceSubCategoryName,
        'timeOfBooking': Timestamp.now(),
        'bookingUID': bookingId,
      };
      DocumentReference serviceProviderRef =
          _firestore.collection('serviceProviders').doc(serviceProviderUID);
      CollectionReference myOrdersCollectionRef =
          serviceProviderRef.collection('myOrders');
      await myOrdersCollectionRef.doc(bookingId).set({
        'orderID': bookingId,
      });
      await orderRef.set(orderData);
    } catch (e) {
      print('Error adding order: $e');
      throw e;
    }
  }
}
