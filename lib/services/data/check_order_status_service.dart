import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handyman/models/bookings_model.dart';

class OrderStatusService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> checkOrderStatus(String bookingID) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firestore.collection('orders').doc(bookingID).get();
      OrderStatusModel initialOrderStatus =
          OrderStatusModel(OrderStatus.initiated);
      OrderStatusModel confirmedOrderStatus =
          OrderStatusModel(OrderStatus.confirmed);
      if (documentSnapshot.exists &&
          documentSnapshot.data()?['status'] == initialOrderStatus.toString()) {
        return initialOrderStatus.toString();
      } else if (documentSnapshot.exists &&
          documentSnapshot.data()?['status'] ==
              confirmedOrderStatus.toString()) {
        return confirmedOrderStatus.toString();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
