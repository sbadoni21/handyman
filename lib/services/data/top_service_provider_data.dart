import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handyman/models/service_provider_model.dart';
import 'package:riverpod/riverpod.dart';
final ServiceProviderService = FutureProvider<List<ServiceProvider>>((ref) async { 
  final serviceProviderData = TopServiceProviderData();
  return serviceProviderData.topServiceProviders();
});

class TopServiceProviderData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ServiceProvider>> topServiceProviders() async {
    try {
      QuerySnapshot topProvidersSnapshot = await FirebaseFirestore.instance
          .collection('topServiceProviders')
          .get();
      List<dynamic> serviceProviderUIDs = topProvidersSnapshot.docs
          .map((doc) => doc.get('serviceProviderUID'))
          .toList();
      List<ServiceProvider> serviceProviders = [];
      for (String uid in serviceProviderUIDs) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('serviceProviders')
            .doc(uid)
            .get();

        if (userSnapshot.exists) {
          ServiceProvider serviceProvider = ServiceProvider.fromMap(
              userSnapshot.data() as Map<String, dynamic>);
          serviceProviders.add(serviceProvider);
        }
      }
      return serviceProviders;
    } catch (e) {
      throw Exception("Error fetching meetings: $e");
    }
  }
}
