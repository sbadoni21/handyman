import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/screens/home_screen.dart';
import 'package:handyman/services/orders/place_order_service.dart';
import 'package:random_string/random_string.dart';

class ServiceBookingPage extends ConsumerStatefulWidget {
  const ServiceBookingPage({super.key});

  @override
  _ServiceBookingPageState createState() => _ServiceBookingPageState();
}

class _ServiceBookingPageState extends ConsumerState<ServiceBookingPage> {
  @override
  void initstate() {
    super.initState();
    User? user = ref.read(userProvider);
  }

  Future<void> _handleOrders(user, serviceProvider, serviceCost, serviceName,
      serviceSubCategoryName) async {
    String bookingId = randomAlphaNumeric(10);
    await OrderServices().addOrder(user, serviceProvider, bookingId,
        serviceCost, serviceName, serviceSubCategoryName);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
