import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handyman/models/service_categories_model.dart';
import 'package:riverpod/riverpod.dart';

final serviceCategoriesServiceProvider =
    FutureProvider<List<ServiceCategoryModel>>((ref) async {
  final serviceCategoriesData = ServiceCategoriesData();
  return serviceCategoriesData.getServiceCategories();
});

class ServiceCategoriesData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ServiceCategoryModel>> getServiceCategories() async {
    try {
      QuerySnapshot serviceCategoriesSnapshot =
          await _firestore.collection('models').get();

      List<ServiceCategoryModel> serviceCategoriesList =
          serviceCategoriesSnapshot.docs
              .map((doc) => ServiceCategoryModel.fromMap(
                  doc.data() as Map<String, dynamic>))
              .toList();
      return serviceCategoriesList;
    } catch (e) {
      throw Exception("Error fetching service categories: $e");
    }
  }
}
