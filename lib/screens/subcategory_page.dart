import 'package:flutter/material.dart';
import 'package:handyman/models/service_categories_model.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:handyman/widgets/customappbar.dart';

class SubCategoryPage extends StatelessWidget {
  final List<SubCategoryService> subCategoryServices;

  const SubCategoryPage({required this.subCategoryServices});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView.builder(
        itemCount: subCategoryServices.length,
        itemBuilder: (context, index) {
          final subCategoryService = subCategoryServices[index];
          return ListTile(
            title: Text(subCategoryService.subCategoryServiceName),
          );
        },
      ),
    );
  }
}
