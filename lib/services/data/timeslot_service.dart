import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handyman/models/time_slots_model.dart';

class TimeSlotsService {
  final CollectionReference _timeSlotsCollection =
      FirebaseFirestore.instance.collection('timeSlots');

  Future<List<TimeSlots>> getTimeSlots() async {
    try {
      QuerySnapshot querySnapshot = await _timeSlotsCollection.get();
      List<TimeSlots> timeSlotsList = querySnapshot.docs
          .map((doc) => TimeSlots.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return timeSlotsList;
    } catch (e) {
      print('Error fetching time slots: $e');
      throw e;
    }
  }
}
