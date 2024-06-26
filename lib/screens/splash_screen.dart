
import 'package:flutter/material.dart';
import 'package:handyman/notifier/user_state_notifier.dart';
import 'package:handyman/screens/home_screen.dart';
import 'package:handyman/screens/login_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(
      userStateNotifierProvider,
    );
    return SafeArea(
        child: AnimatedSplashScreen(
      animationDuration: const Duration(seconds: 2),
      duration: 3000,
      // splash: (
      //   children: [

      //     // const Text(
      //     //   "Vidhyamani",
      //     //   style: TextStyle(
      //     //     color: Colors.white,
      //     //     fontSize: 24,
      //     //     fontWeight: FontWeight.w600,
      //     //   ),
      //     // )
      //   ]
      // ),
      splash: ListView(
        children: [
          Image.asset(
            "assets/images/logoblack.png",
            height: 270,
            width: 270,
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              "Handy Hands",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
      splashIconSize: 350,
      centered: true,

      nextScreen: userState == null ? LoginPage() : HomeScreen(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.bottomToTop,
      backgroundColor: Colors.white,
    ));
  }
}
