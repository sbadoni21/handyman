import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handyman/models/service_categories_model.dart';
import 'package:handyman/models/service_provider_model.dart';
import 'package:handyman/models/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final serviceProviderRepositoryProvider =
    Provider<ServiceProviderRepository>((ref) => ServiceProviderRepository());

class ServiceProviderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ServiceProvider>> getServiceProvidersForSubServiceCategory(
      String subServiceCategoryUID) async {
    try {
      QuerySnapshot<Map<String, dynamic>> serviceProvidersSnapshot =
          await _firestore
              .collection('serviceProviders')
              .where('serviceSubCategories',
                  arrayContains: subServiceCategoryUID)
              .get();
      print(serviceProvidersSnapshot.docs);
      List<ServiceProvider> serviceProvidersList = serviceProvidersSnapshot.docs
          .map((doc) =>
              ServiceProvider.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      print(serviceProvidersList);
      for (var serviceProvider in serviceProvidersList) {
        print("ServiceProvider Data:");
        print("Name: ${serviceProvider.name}");
        print("Location: ${serviceProvider.location}");
        print("-----------");
      }

      return serviceProvidersList;
    } catch (e) {
      throw Exception("Error fetching service providers: $e");
    }
  }
}
