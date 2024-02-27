import 'package:flutter/material.dart';
import 'package:handyman/utils/app_colors.dart';

class CategoryItem extends StatelessWidget {
  final String imgUrl;
  final String text;

  const CategoryItem({
    Key? key,
    required this.imgUrl,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          child: Image.asset(imgUrl, fit: BoxFit.fill),
        ),
        SizedBox(height: 2),
        Container(
            width: 110,
            child: Text(
              text,
              style: myTextStylefontsize12WhiteW300,
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}
