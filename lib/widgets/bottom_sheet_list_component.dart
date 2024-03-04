import 'package:flutter/material.dart';
import 'package:handyman/models/service_categories_model.dart';
import 'package:handyman/utils/app_colors.dart';

class BottomSheetListComponent extends StatelessWidget {
  Service service;

  BottomSheetListComponent({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: service.servicePhoto.isNotEmpty
                      ? NetworkImage(service.servicePhoto)
                      : AssetImage('assets/images/placeholder_image.png')
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
            height: 40,
            width: 120,
            child: Text(service.serviceName,
                style: const TextStyle(
                    fontSize: 14, color: bgColor, fontWeight: FontWeight.w600)))
      ],
    );
  }
}
