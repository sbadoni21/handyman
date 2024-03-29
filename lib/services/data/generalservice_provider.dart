// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:handyman/models/service_provider_model.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// final generalServiceProvider =
//     Provider<GeneralServiceProvider>((ref) => GeneralServiceProvider());

// class GeneralServiceProvider {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<List<ServiceProvider>> getServiceProvidersForServiceCategory(
//       String serviceCategoryUID) async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> serviceProvidersSnapshot =
//           await _firestore.collection('serviceProviders').get();
//       List<ServiceProvider> serviceProvidersList = serviceProvidersSnapshot.docs
//           .map((doc) =>
//               ServiceProvider.fromMap(doc.data() as Map<String, dynamic>))
//           .toList();
//       List<ServiceProvider> filteredServiceProviders = serviceProvidersList
//           .where((serviceProvider) => serviceProvider.serviceCategories.any(
//               (subCategory) =>
//                   subCategory.serviceCategoryUID == serviceCategoryUID))
//           .toList();

 

//       return filteredServiceProviders;
//     } catch (e) {
//       throw Exception("Error fetching service providers: $e");
//     }
//   }
// }
