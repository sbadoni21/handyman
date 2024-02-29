import 'package:flutter/material.dart';
import 'package:handyman/models/service_categories_model.dart';
import 'package:handyman/utils/app_colors.dart';

class SubCategoryLongTile extends StatelessWidget {
  SubCategoryService subCategoryService;

  SubCategoryLongTile({
    Key? key,
    required this.subCategoryService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                subCategoryService.subCategoryServicePhoto,
                fit: BoxFit.fill,
                height: 50,
                width: 50,
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subCategoryService.subCategoryServiceName,
                style: myTextStylefontsize14WhiteW400,
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          )
        ],
      ),
    );
  }
}
