import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/notifier/user_state_notifier.dart';

final userProvider = Provider<User?>((ref) {
  return ref.watch(userStateNotifierProvider);
});

class MyBookings extends ConsumerStatefulWidget {
  const MyBookings({super.key});

  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends ConsumerState<MyBookings> {
  @override
  Widget build(BuildContext context) {
    User? user = ref.read(userProvider);
    return Scaffold(
      body: ListView(
        children: [Text(user!.displayName)],
      ),
    );
  }
}
