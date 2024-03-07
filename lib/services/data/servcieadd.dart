import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handyman/models/service_categories_model.dart';

class ServiceCategoryService {
  final CollectionReference _categoriesCollection =
      FirebaseFirestore.instance.collection('service_categories');

  Future<void> addServiceCategory(ServiceCategoryModel category) async {
    await _categoriesCollection.doc(category.serviceModelUID).set({
      'serviceModelUID': category.serviceModelUID,
      'services': category.services.map((service) => service.toMap()).toList(),
      'servicePhoto': category.servicePhoto,
      'serviceModelName': category.serviceModelName,
    });
  }
}
