import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handyman/models/service_categories_model.dart';
import 'package:handyman/models/service_provider_model.dart';

class ServiceProviderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<Map<String, dynamic>>> getServiceProviders(
      SubCategoryService subCategoryService) async {
    try {
      QuerySnapshot<Map<String, dynamic>> indexesSnapshot = await _firestore
          .collection('indexes')
          .doc(subCategoryService.serviceModelUID)
          .collection(subCategoryService.serviceCategoryUID)
          .where('subServiceCategories', arrayContainsAny: [
        subCategoryService.subCategoryServiceUID
      ]).get();

      List<String> providerUIDs = [];
      indexesSnapshot.docs.forEach((doc) {
        String providerUID = doc['providerUID'] as String;
        providerUIDs.add(providerUID);
      });

      List<Map<String, dynamic>> serviceProvidersData = [];

      for (String providerUID in providerUIDs) {
        QuerySnapshot<Map<String, dynamic>> serviceProviderSnapshot =
            await _firestore
                .collection('serviceProviders')
                .where('uid', isEqualTo: providerUID)
                .get();

        for (DocumentSnapshot<Map<String, dynamic>> doc
            in serviceProviderSnapshot.docs) {
          Map<String, dynamic>? data = doc.data();
          if (data != null) {
            try {
              ServiceProvider serviceProvider = ServiceProvider.fromMap(data);
              if (serviceProvider.services != null) {
                for (Services service in serviceProvider.services!) {
                  for (SubService subService in service.subServiceCategories!) {
                    if (subService.subCategoryServiceUID ==
                        subCategoryService.subCategoryServiceUID) {
                      Map<String, dynamic> serviceProviderData = {
                        'serviceProviderUID': serviceProvider.uid,
                        'serviceCategoryName':
                            subService.subCategoryServiceName,
                        'serviceCategoryUID': subService.serviceCategoryUID,
                        'serviceProviderName': serviceProvider.name,
                        'subCategoryServiceName':
                            subCategoryService.subCategoryServiceName,
                        'subCategoryServiceUID':
                            subCategoryService.subCategoryServiceUID,
                        'cost': subService.rate,
                        'photo': serviceProvider.photo,
                        'rating': serviceProvider.rating,
                      };
                      serviceProvidersData.add(serviceProviderData);
                    }
                  }
                }
              }
            } catch (e) {
              print("Error processing document: $e");
            }
          } else {
            print("Document data is null.");
          }
        }
      }

      print("Service providers data: $serviceProvidersData");
      return serviceProvidersData;
    } catch (e) {
      print("Error fetching service providers: $e");
      throw Exception("Error fetching service providers: $e");
    }
  }
}
