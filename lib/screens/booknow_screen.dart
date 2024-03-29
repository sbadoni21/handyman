import 'package:flutter/material.dart';
import 'package:handyman/models/service_provider_model.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/notifier/user_state_notifier.dart';
import 'package:handyman/screens/bookings_serviceprovider_confirmation_screen.dart';
import 'package:handyman/screens/home_screen.dart';
import 'package:handyman/services/orders/place_order_service.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:handyman/widgets/customappbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:random_string/random_string.dart';

class BookNowScreen extends ConsumerStatefulWidget {
  final String serviceProviderUID;
  final String serviceCategoryName;
  final String serviceCategoryUID;
  final String serviceProviderName;
  final String subCategoryServiceName;
  final String subCategoryServiceUID;
  final String cost;

  const BookNowScreen(
      {Key? key,
      required this.serviceProviderUID,
      required this.serviceCategoryName,
      required this.serviceCategoryUID,
      required this.serviceProviderName,
      required this.subCategoryServiceName,
      required this.subCategoryServiceUID,
      required this.cost})
      : super(key: key);
  @override
  _BookNowScreenState createState() => _BookNowScreenState();
}

class _BookNowScreenState extends ConsumerState<BookNowScreen> {
  @override
  void initState() {
    super.initState();
  }

  bool isBooking = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: !isBooking
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              onPressed: () async {
                setState(() {
                  isBooking = true;
                });
                User? user = ref.read(userStateNotifierProvider);
                String bookingId = randomAlphaNumeric(10);
                await OrderServices().addOrder(
                    user!,
                    widget.serviceProviderUID,
                    bookingId,
                    widget.cost,
                    widget.serviceCategoryName,
                    widget.subCategoryServiceName);
                setState(() {
                  isBooking = false;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BookingServiceProviderConfirmationScreen(
                              bookingID: bookingId,
                            )));
              },
              child: Text(
                'Book Now',
                style: myTextStylefontsize12WhiteW300,
              ),
            )
          : CircularProgressIndicator(),
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: [
            Lottie.asset('assets/lottie/locationforpayment.json'),
            _buildOrderDetails(),
            SizedBox(
              height: 10,
            ),
            // _buildReviews()
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(title, style: myTextStylefontsize12WhiteW300),
          ),
          Expanded(
            child: Text(
              value,
              style: myTextStylefontsize12WhiteW300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails() {
    User? user = ref.read(userStateNotifierProvider);
    return Container(
      decoration: const BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking Details',
              style: myTextStylefontsize16white,
            ),
            _buildDetailRow('Service Name', widget.serviceCategoryName),
            _buildDetailRow('Provider Name', widget.serviceProviderName),
            _buildDetailRow(
                'Service Subcategory', widget.subCategoryServiceName),
            _buildDetailRow('Service Cost', widget.cost.toString()),
            _buildDetailRow('Service Location', user!.location),
          ],
        ),
      ),
    );
  }

  // Widget _buildReviews() {
  //   return Container(
  //     decoration: BoxDecoration(
  //         color: bgColor, borderRadius: BorderRadius.all(Radius.circular(20))),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Previous Reviews',
  //             style: myTextStylefontsize16white,
  //           ),
  //           SizedBox(
  //             height: 300,
  //             child: ListView.builder(
  //               shrinkWrap:
  //                   true,
  //               itemCount: widget
  //                   .serviceSubCategories.subServiceCategoryReviews!.length,
  //               itemBuilder: (context, index) {
  //                 SubServiceCategoryReviews review = widget
  //                     .serviceSubCategories.subServiceCategoryReviews![index];
  //                 return ListTile(
  //                   title: Text(
  //                     review.customerName,
  //                     style: myTextStylefontsize12WhiteW300,
  //                   ),
  //                   subtitle: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         ' Review : ${review.customerReview}',
  //                         style: myTextStylefontsize12WhiteW300,
  //                       ),
  //                       Text(
  //                         ' OrderId : ${review.customerOrderId}',
  //                         style: myTextStylefontsize12WhiteW300,
  //                       ),
  //                     ],
  //                   ),
  //                   trailing: Text(
  //                     review.customerRating,
  //                     style: myTextStylefontsize12WhiteW300,
  //                   ),
  //                   leading: Icon(
  //                     Ionicons.person_circle_outline,
  //                     color: Colors.white,
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
