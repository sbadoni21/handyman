import 'package:flutter/material.dart';
import 'package:handyman/models/service_categories_model.dart';
import 'package:handyman/screens/subcategory_service_detail_page.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:handyman/widgets/customappbar.dart';
import 'package:handyman/widgets/subcategory_long_tile.dart';

class SubCategoryPage extends StatelessWidget {
  final List<SubCategoryService> subCategoryServices;

  const SubCategoryPage({required this.subCategoryServices});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "What are you looking for?",
            style: myTextStylefontsize16white,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: subCategoryServices.length,
              itemBuilder: (context, index) {
                final subCategoryService = subCategoryServices[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SubCategoryServiceDetailsPage(
                                      subCategoryService:
                                          subCategoryService)));
                    },
                    child: SubCategoryLongTile(
                        subCategoryService: subCategoryService),
                  ),
                );
              },
            ),
          ),
          Text(
            "Hey! You can search something specific on the search bar",
            style: myTextStylefontsize12WhiteW300,
          ),
        ]),
      ),
    );
  }
}
