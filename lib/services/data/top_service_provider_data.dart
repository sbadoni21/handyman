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
      QuerySnapshot topProvidersSnapshot =
          await _firestore.collection('topServiceProviders').get();

      List<String> serviceProviderUIDs = topProvidersSnapshot.docs
          .map((doc) => doc.get('serviceProviderUID'))
          .cast<String>()
          .toList();

      List<ServiceProvider> serviceProviders = [];

      for (String uid in serviceProviderUIDs) {
        DocumentSnapshot userSnapshot =
            await _firestore.collection('serviceProviders').doc(uid).get();
        if (userSnapshot.exists) {
          ServiceProvider serviceProvider = ServiceProvider.fromMap(
              userSnapshot.data() as Map<String, dynamic>);
          serviceProviders.add(serviceProvider);
          print(serviceProviders);
        }
      }

      // Print the data
      serviceProviders.forEach((serviceProvider) {
        print("ServiceProvider Data:");
        print("Name: ${serviceProvider.name}");
        // Add more fields as needed
        print("-----------");
      });

      return serviceProviders;
    } catch (e) {
      throw Exception("Error fetching service providers: $e");
    }
  }
}
