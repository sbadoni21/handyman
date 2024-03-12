import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:handyman/models/bookings_model.dart';
import 'package:handyman/services/data/check_order_status_service.dart';
import 'package:handyman/widgets/customappbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookingServiceProviderConfirmationScreen extends ConsumerStatefulWidget {
  final String bookingID;

  const BookingServiceProviderConfirmationScreen(
      {Key? key, required this.bookingID})
      : super(key: key);

  @override
  _BookingServiceProviderConfirmationScreenState createState() =>
      _BookingServiceProviderConfirmationScreenState();
}

class _BookingServiceProviderConfirmationScreenState
    extends ConsumerState<BookingServiceProviderConfirmationScreen> {
  late Timer _timer;
  late String? status;
  late String? state;

  @override
  void initState() {
    super.initState();
    _startTimer();
    status = OrderStatusModel(OrderStatus.initiated).toString();
    state = OrderStatusModel(OrderStatus.initiated).toString();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (Timer timer) async {
      state = await OrderStatusService().checkOrderStatus(widget.bookingID);
      setState(() {
        status = state;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        children: [
          Center(
            child: CircularCountDownTimer(
              duration: 300,
              initialDuration: 0,
              controller: CountDownController(),
              width: 150,
              height: 150,
              ringColor: Colors.grey[300]!,
              ringGradient: null,
              fillColor: Colors.blue,
              fillGradient: null,
              backgroundColor: Colors.white,
              strokeWidth: 5.0,
              strokeCap: StrokeCap.round,
              textStyle: const TextStyle(fontSize: 30, color: Colors.black),
              textFormat: CountdownTextFormat.MM_SS,
              isReverseAnimation: false,
              isTimerTextShown: true,
              autoStart: true,
              onComplete: () {},
            ),
          ),
          Text(status ?? ''),
        ],
      ),
    );
  }
    @override
  void dispose() {
    super.dispose();
    
  }
}
