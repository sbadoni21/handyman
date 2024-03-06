import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handyman/models/bookings_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class MyBookingsProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<BookingModel>> getBookingsUsers(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>>  userSnapshot =
          await _firestore.collection('users').doc(userId).get();

      List<String> myOrdersUIDs =
        await  userSnapshot.get('myOrders')?.cast<String>() ?? [];

      List<BookingModel> myBookings = [];

      for (String uid in myOrdersUIDs) {
        DocumentSnapshot orderSnapshot =
            await _firestore.collection('orders').doc(uid).get();
        if (orderSnapshot.exists) {
          BookingModel booking = BookingModel.fromMap(
              orderSnapshot.data() as Map<String, dynamic>);
          myBookings.add(booking);
        } else {
          print('Order with UID $uid does not exist.');
        }
      }

      return myBookings;
    } catch (e, stackTrace) {
      print('Error fetching service providers: $e');
      print(stackTrace);
      return [];
    }
  }
}
