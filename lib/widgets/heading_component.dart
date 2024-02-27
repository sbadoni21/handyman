import 'package:flutter/material.dart';
import 'package:handyman/utils/app_colors.dart';

class HeadingTitle extends StatelessWidget {
  final String title;

  const HeadingTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: myTextStylefontsize19White);
  }
}
