import 'package:flutter/material.dart';
import 'package:handyman/widgets/customappbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class BookingServiceProviderConfirmationScreen extends ConsumerStatefulWidget {
  const BookingServiceProviderConfirmationScreen({Key? key}) : super(key: key);

  @override
  _BookingServiceProviderConfirmationScreenState createState() =>
      _BookingServiceProviderConfirmationScreenState();
}

class _BookingServiceProviderConfirmationScreenState
    extends ConsumerState<BookingServiceProviderConfirmationScreen> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        children: [
        
        ]
      ),
    );
  }
}
