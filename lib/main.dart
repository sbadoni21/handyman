import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/notifier/user_state_notifier.dart';
import 'package:handyman/screens/home_screen.dart';
import 'package:handyman/screens/splash_screen.dart';
import 'package:logger/logger.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final logger = Logger(
    printer: PrettyPrinter(),
  );
  try {
    Platform.isAndroid
        ? await Firebase.initializeApp(
            options: const FirebaseOptions(
                apiKey: "AIzaSyC2M3UWATaGqkCa1Vn2eq_pmIS63_3-k8s",
                authDomain: "handyman-5ce4f.firebaseapp.com",
                projectId: "handyman-5ce4f",
                storageBucket: "handyman-5ce4f.appspot.com",
                messagingSenderId: "902375901390",
                appId: "1:902375901390:web:6f9fbd993a654e74e1289f",
                measurementId: "G-L7HL2B1DRS"))
        : Firebase.initializeApp();
    logger.i("Firebase initialized successfully");
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    runApp(ProviderScope(child: MyApp()));
  } catch (e) {
    logger.e("Firebase initialization error: $e");
  }
}

@pragma("vm:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC2M3UWATaGqkCa1Vn2eq_pmIS63_3-k8s",
      appId: "1:902375901390:web:6f9fbd993a654e74e1289f",
      messagingSenderId: "902375901390",
      projectId: "handyman-5ce4f",
    ),
  );

  // Your background handler logic goes here
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(
      userStateNotifierProvider,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Handyman',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: navigatorKey,
      home: userState == null ? const SplashScreen() : const HomeScreen(),
    );
  }
}

class ErrorApp extends StatelessWidget {
  final String errorMessage;
  const ErrorApp(this.errorMessage);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error',
      home: Scaffold(
        body: Center(
          child: Text(errorMessage),
        ),
      ),
    );
  }
}
