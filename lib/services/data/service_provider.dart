// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:handyman/models/service_provider_model.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// final serviceProviderRepositoryProvider =
//     Provider<ServiceProviderRepository>((ref) => ServiceProviderRepository());

// class ServiceProviderRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<List<ServiceProvider>> getServiceProvidersForSubServiceCategory(
//       String subServiceCategoryUID) async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> serviceProvidersSnapshot =
//           await _firestore.collection('serviceProviders').get();
//       List<ServiceProvider> serviceProvidersList = serviceProvidersSnapshot.docs
//           .map((doc) =>
//               ServiceProvider.fromMap(doc.data() as Map<String, dynamic>))
//           .toList();
//       List<ServiceProvider> filteredServiceProviders = serviceProvidersList
//           .where((serviceProvider) => serviceProvider.serviceModel.any(
//               (subCategory) =>
//                   subCategory.subServiceCategoryUID == subServiceCategoryUID))
//           .toList();

//       for (var serviceProvider in filteredServiceProviders) {
//         print(serviceProvider);
//       }

//       return filteredServiceProviders;
//     } catch (e) {
//       throw Exception("Error fetching service providers: $e");
//     }
//   }
// }
