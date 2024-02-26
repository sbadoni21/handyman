
import 'package:flutter/material.dart';
import 'package:handyman/screens/home_screen.dart';

List<Map<String, dynamic>> sideMenuItems = [
  {
    "icon": Icons.home,
    "text": "Home",
    "key": "home",
    'route': const HomeScreen()
  },

  // {
  //   "icon": Icons.contact_mail,
  //   "text": "Contact Us",
  //   "key": "contact",
  //   'route': ContactUsPage(),
  // },
  // {
  //   "icon": Icons.question_mark,
  //   "text": "Help",
  //   "key": "aboutus",
  //   'route': AboutAppPage()
  // },
  {
    "icon": Icons.logout,
    "text": "Logout",
    "key": "logout",
    "route": () async {}
  }
];
