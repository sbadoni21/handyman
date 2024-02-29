import 'package:flutter/material.dart';
import 'package:handyman/models/service_provider_model.dart';
import 'package:handyman/utils/app_colors.dart';

class Tiles extends StatelessWidget {
  ServiceProvider serviceProvider;
  Tiles({
    Key? key,
    required this.serviceProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: serviceProvider.photo.isNotEmpty
                      ? NetworkImage(serviceProvider.photo)
                      : AssetImage('assets/images/placeholder_image.png')
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              left: 4,
              child: Container(
                  padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    serviceProvider.rating,
                    style: myTextStylefontsize14BlackW400,
                  )),
            ),
          ],
        ),
        Container(
            height: 40,
            width: 120,
            child: Text(serviceProvider.name,
                style: myTextStylefontsize12WhiteW300))
      ],
    );
  }
}
