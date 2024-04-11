import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handyman/models/bookings_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final myBookingsProvider = ChangeNotifierProvider<MyBookingsProvider>((ref) {
  return MyBookingsProvider();
});

class MyBookingsProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<BookingModel>> getBookingsUsers(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('users').doc(userId).get();

      List<String> myOrdersUIDs =
          userSnapshot.data()?['myOrders']?.cast<String>() ?? [];
      print(myOrdersUIDs);
      List<BookingModel> myBookings = [];

      for (String uid in myOrdersUIDs) {
        DocumentSnapshot orderSnapshot =
            await _firestore.collection('orders').doc(uid).get();
        if (orderSnapshot.exists) {
          Map<String, dynamic>? orderData =
              orderSnapshot.data() as Map<String, dynamic>?;
          if (orderData != null) {
            BookingModel booking = BookingModel.fromMap(orderData);
            myBookings.add(booking);
          } else {
            print('Order with UID $uid does not exist.');
          }
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

  Future<void> addReview(String bookingId, String review) async {
    try {
      await _firestore.collection('orders').doc(bookingId).update({
        'review': review,
      });
      print('Review added successfully');
    } catch (e) {
      print('Error adding review: $e');
      throw e;
    }
  }
}
