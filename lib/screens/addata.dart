// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:handyman/models/service_categories_model.dart';

// class AddServiceCategoryScreen extends StatefulWidget {
//   @override
//   _AddServiceCategoryScreenState createState() =>
//       _AddServiceCategoryScreenState();
// }

// class _AddServiceCategoryScreenState extends State<AddServiceCategoryScreen> {
//   final TextEditingController _serviceModelUIDController =
//       TextEditingController();
//   final TextEditingController _serviceModelNameController =
//       TextEditingController();
//   final TextEditingController _servicePhotoController = TextEditingController();

//   final TextEditingController _serviceNameController = TextEditingController();
//   final TextEditingController _serviceUIDController = TextEditingController();
//   final TextEditingController _subCategoryServiceNameController =
//       TextEditingController();
//   final TextEditingController _subCategoryServiceUIDController =
//       TextEditingController();
//   final TextEditingController _subCategoryServicePhotoController =
//       TextEditingController();
//   final TextEditingController _serviceCategoryUIDController =
//       TextEditingController();
//   final TextEditingController _noOfUsersController = TextEditingController();

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Service Category'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Service Model UID'),
//               TextField(controller: _serviceModelUIDController),
//               SizedBox(height: 16),
//               Text('Service Model Name'),
//               TextField(controller: _serviceModelNameController),
//               SizedBox(height: 16),
//               Text('Service Photo'),
//               TextField(controller: _servicePhotoController),
//               SizedBox(height: 16),
//               Text('Service Name'),
//               TextField(controller: _serviceNameController),
//               SizedBox(height: 16),
//               Text('Service UID'),
//               TextField(controller: _serviceUIDController),
//               SizedBox(height: 16),
//               Text('Sub-Category Service Name'),
//               TextField(controller: _subCategoryServiceNameController),
//               SizedBox(height: 16),
//               Text('Sub-Category Service UID'),
//               TextField(controller: _subCategoryServiceUIDController),
//               SizedBox(height: 16),
//               Text('Sub-Category Service Photo'),
//               TextField(controller: _subCategoryServicePhotoController),
//               SizedBox(height: 16),
//               Text('Service Category UID'),
//               TextField(controller: _serviceCategoryUIDController),
//               SizedBox(height: 16),
//               Text('No of Users'),
//               TextField(controller: _noOfUsersController),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () async {
//                   await _addServiceCategory();
//                 },
//                 child: Text('Submit Service Category'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _addServiceCategory() async {
//     SubCategoryService subCategoryService = SubCategoryService(
//       subCategoryServiceName: _subCategoryServiceNameController.text,
//       subCategoryServiceUID: _subCategoryServiceUIDController.text,
//       subCategoryServicePhoto: _subCategoryServicePhotoController.text,
//       serviceCategoryUID: _serviceCategoryUIDController.text,
//       noOfUsers: int.parse(_noOfUsersController.text),
//     );

//     Service service = Service(
//       servicePhoto: _servicePhotoController.text,
//       serviceName: _serviceNameController.text,
//       serviceUID: _serviceUIDController.text,
//       subCategoryServices: [subCategoryService],
//     );

//     ServiceCategoryModel serviceCategoryModel = ServiceCategoryModel(
//       serviceModelUID: _serviceModelUIDController.text,
//       serviceModelName: _serviceModelNameController.text,
//       servicePhoto: _servicePhotoController.text,
//       services: [service],
//     );

//     Map<String, dynamic> subCategoryServiceMap = subCategoryService.toMap();
//     Map<String, dynamic> serviceMap = service.toMap();
//     Map<String, dynamic> serviceCategoryModelMap = serviceCategoryModel.toMap();

//     await _firestore
//         .collection('models')
//         .doc(_serviceModelUIDController.text)
//         .set({
//       'serviceModelName': serviceCategoryModel.serviceModelName,
//       'serviceModelUID': serviceCategoryModel.serviceModelUID,
//       'servicePhoto': serviceCategoryModel.servicePhoto,
//       'services': [serviceMap],
//     });

//     // _clearTextControllers();
//   }

//   void _clearTextControllers() {
//     _serviceModelUIDController.clear();
//     _serviceModelNameController.clear();
//     _servicePhotoController.clear();
//     _serviceNameController.clear();
//     _serviceUIDController.clear();
//     _subCategoryServiceNameController.clear();
//     _subCategoryServiceUIDController.clear();
//     _subCategoryServicePhotoController.clear();
//     _serviceCategoryUIDController.clear();
//     _noOfUsersController.clear();
//   }
// }
