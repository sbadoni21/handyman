import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/models/bookings_model.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/notifier/user_state_notifier.dart';
import 'package:handyman/services/data/mybookings_service.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:lottie/lottie.dart';

final userProvider = Provider<User?>((ref) {
  return ref.watch(userStateNotifierProvider);
});

class MyBookings extends ConsumerStatefulWidget {
  const MyBookings({super.key});

  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends ConsumerState<MyBookings> {
  late FutureProvider<List<BookingModel>> myBookings;

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
          // _buildGeneralServiceProviders(),
        ],
      ),
    );
  }
// Widget _buildGeneralServiceProviders() {
//   return Container(
//     height: 250,
//     width: double.infinity,
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.only(
//         bottomLeft: Radius.circular(20),
//         bottomRight: Radius.circular(20),
//       ),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: ref.read(myBookingProvider).(
//         loading: () => SizedBox(
//           height: 250,
//           width: 250,
//           child: Lottie.asset('assets/lottie/loading.json'),
//         ),
//         error: (error, stack) {
//           print('Error: $error');
//           print(stack);
//           return Text('Error: $error');
//         },
//         data: (myBookings) {
//           if (myBookings == null || myBookings.isEmpty) {
//             return Text('No bookings available.');
//           }
//           return ListView.builder(
//             scrollDirection: Axis.horizontal,
//             shrinkWrap: true,
//             physics: AlwaysScrollableScrollPhysics(),
//             itemCount: myBookings.length,
//             itemBuilder: (context, index) {
//               final BookingModel booking = myBookings[index];
//               return Text(
//                 booking.review ?? 'Review is null',
//                 style: myTextStylefontsize10BGCOLOR,
//               );
//             },
//           );
//         },
//       ),
//     ),
//   );
// }


}
