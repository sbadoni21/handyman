import 'package:flutter/material.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:ionicons/ionicons.dart';

class CustomBottomNavigationBar extends StatefulWidget
    implements PreferredSizeWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();

  Size get preferredSize => Size.fromHeight(60);
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: BottomNavigationBar(
        iconSize: 25,
        elevation: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: bgColor,
        type: BottomNavigationBarType.fixed,
        enableFeedback: true,
        currentIndex: widget.currentIndex,
        onTap: widget.onTap,
        selectedLabelStyle: myTextStylefontsize12WhiteW300,
        unselectedLabelStyle: myTextStylefontsize10White,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              widget.currentIndex == 0 ? Ionicons.home : Ionicons.home_outline,
              size: 25,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              widget.currentIndex == 1 ? Ionicons.book : Ionicons.book_outline,
              size: 25,
            ),
            label: "My Bookings",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              widget.currentIndex == 2 ? Ionicons.gift : Ionicons.gift_outline,
              size: 25,
            ),
            label: "Rewards",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              widget.currentIndex == 3
                  ? Ionicons.person
                  : Ionicons.person_outline,
              size: 25,
            ),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
