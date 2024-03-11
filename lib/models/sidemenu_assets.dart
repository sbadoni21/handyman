import 'package:flutter/material.dart';
import 'package:handyman/screens/helpcenter_screen.dart';
import 'package:handyman/screens/home_screen.dart';
import 'package:handyman/screens/plus_membership_sceen.dart';
import 'package:handyman/screens/setting_screen.dart';

List<Map<String, dynamic>> sideMenuItems = [
  {
    "icon": Icons.home,
    "text": "Home",
    "key": "home",
    'route': const HomeScreen()
  },
  {
    "icon": Icons.call,
    "text": "Help Center",
    "key": "helpCenter",
    'route': const HelpCenterScreen(),
  },
  {
    "icon": Icons.star_border,
    "text": "Plus Membership",
    "key": "plusMemberShip",
    'route': PlusMemberShipScreen(),
  },
  {
    "icon": Icons.settings,
    "text": "Settings",
    "key": "aboutus",
    'route': SettingsPage()
  },
  {
    "icon": Icons.logout,
    "text": "Logout",
    "key": "logout",
    "route": () async {}
  }
];
