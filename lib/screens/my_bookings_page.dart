import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/models/bookings_model.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/notifier/user_state_notifier.dart';
import 'package:handyman/screens/bookings_details_page.dart';
import 'package:handyman/screens/home_screen.dart';
import 'package:handyman/services/data/mybookings_service.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class MyBookings extends ConsumerStatefulWidget {
  const MyBookings({Key? key}) : super(key: key);

  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends ConsumerState<MyBookings> {
  late FutureProvider<List<BookingModel>> myBookingsProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text(
          'My Bookings',
          style: myTextStylefontsize16white,
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            _buildMyBookingsProvider(),
          ],
        ),
      ),
    );
  }

  Widget _buildMyBookingsProvider() {
    User? user = ref.read(userStateNotifierProvider);
    print(user!.myOrders);
    return FutureBuilder<List<BookingModel>>(
      future: MyBookingsProvider().getBookingsUsers(user!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Lottie.asset(
                'assets/lottie/error404.json',
              ),
              Text(
                'Error 404',
                style: myTextStylefontsize14WhiteW400,
              )
            ],
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Column(
            children: [
              Lottie.asset(
                'assets/lottie/no_orders_found.json',
              ),
              Text(
                'No orders found',
                style: myTextStylefontsize14WhiteW400,
              )
            ],
          );
        } else {
          List<BookingModel> myBookings = snapshot.data!;

          return Expanded(
            child: ListView.builder(
              itemCount: myBookings.length,
              itemBuilder: (context, index) {
                BookingModel booking = myBookings[index];
                DateTime dateTime = booking.timeOfBooking.toDate();
                String formattedDateTime =
                    DateFormat('MMMM d, y, HH:mm a').format(dateTime);
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                MyBookingsDetailsPage(booking: booking))));
                  },
                  tileColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Ionicons.time_outline,
                        size: 10,
                        color: Colors.grey[900],
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "${formattedDateTime}",
                        style: myTextStylefontsize12BGCOLOR,
                      ),
                    ],
                  ),
                  trailing: Text('Charges : ₹ ${booking.serviceCost} '),
                  subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Service Name :  ${booking.serviceName}",
                          style: myTextStylefontsize12BGCOLOR,
                        ),
                        Text(
                          "Service Provider :  ${booking.serviceProviderName}",
                          style: myTextStylefontsize12BGCOLOR,
                        ),
                        Text(
                          "Service Location :  ${booking.serviceLocation}",
                          style: myTextStylefontsize12BGCOLOR,
                        )
                      ]),
                );
              },
            ),
          );
        }
      },
    );
  }
}
