import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/models/bookings_model.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/notifier/user_state_notifier.dart';
import 'package:handyman/screens/home_screen.dart';
import 'package:handyman/services/data/mybookings_service.dart';
import 'package:handyman/utils/app_colors.dart';
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
    User? user = ref.read(userProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Text(
            'My Bookings',
            style: myTextStylefontsize16white,
          ),
          SizedBox(
            height: 10,
          ),
          _buildMyBookingsProvider(),
        ],
      ),
    );
  }

  Widget _buildMyBookingsProvider() {
    User? user = ref.read(userProvider);

    return FutureBuilder<List<BookingModel>>(
      future: MyBookingsProvider().getBookingsUsers(user!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text("No bookings available.");
        } else {
          List<BookingModel> myBookings = snapshot.data!;

          return Expanded(
            child: ListView.builder(
              itemCount: myBookings.length,
              itemBuilder: (context, index) {
                BookingModel booking = myBookings[index];

                return SizedBox(
                  height: 20,
                  child: ListTile(
                    title: Text(
                      "Booking ${index + 1}",
                      style: myTextStylefontsize10White,
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
