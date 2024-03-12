import 'dart:async';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:handyman/models/bookings_model.dart';
import 'package:handyman/services/data/check_order_status_service.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:handyman/widgets/customappbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
  final String confirmed = OrderStatusModel(OrderStatus.confirmed).toString();
  final String initated = OrderStatusModel(OrderStatus.initiated).toString();
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
          status == initated
              ? Lottie.asset('assets/lottie/waiting_for_confirmation.json')
              : Lottie.asset('assets/lottie/confirmation.json'),
          Center(
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 40,
              animation: true,
              lineHeight: 20.0,
              animationDuration: 300000,
              percent: 1.0,
              center: Text(
                "Waiting for confirmation",
                style: myTextStylefontsize12WhiteW300,
              ),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: bgColor,
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
