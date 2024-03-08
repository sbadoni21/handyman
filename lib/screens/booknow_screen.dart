import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handyman/models/service_categories_model.dart';
import 'package:handyman/models/service_provider_model.dart';
import 'package:handyman/models/user.dart';
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
  final ServiceProvider serviceProvider;
  final ServiceSubCategories serviceSubCategories;

  const BookNowScreen(
      {super.key,
      required this.serviceProvider,
      required this.serviceSubCategories});

  @override
  _BookNowScreenState createState() => _BookNowScreenState();
}

class _BookNowScreenState extends ConsumerState<BookNowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
        onPressed: () async {
          User? user = ref.read(userProvider);
          String bookingId = randomAlphaNumeric(10);
          await OrderServices().addOrder(
              user!,
              widget.serviceProvider,
              bookingId,
              widget.serviceSubCategories.subServiceCategoryRate,
              widget.serviceSubCategories.serviceCategoryName,
              widget.serviceSubCategories.serviceSubCategoryName);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BookingServiceProviderConfirmationScreen()));
        },
        child: Text(
          'Book Now',
          style: myTextStylefontsize12WhiteW300,
        ),
      ),
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
            _buildReviews()
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
    User? user = ref.read(userProvider);
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
            _buildDetailRow('Service Name',
                widget.serviceSubCategories.serviceCategoryName),
            _buildDetailRow('Provider Name', widget.serviceProvider.name),
            _buildDetailRow('Service Subcategory',
                widget.serviceSubCategories.serviceSubCategoryName),
            _buildDetailRow('Service Cost',
                widget.serviceSubCategories.subServiceCategoryRate.toString()),
            _buildDetailRow('Service Location', user!.location),
          ],
        ),
      ),
    );
  }

  Widget _buildReviews() {
    return Container(
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Previous Reviews',
              style: myTextStylefontsize16white,
            ),
            SizedBox(
              height: 300, // Set a maximum height if needed
              child: ListView.builder(
                shrinkWrap:
                    true, // Allow the ListView to take only the space it needs
                itemCount: widget
                    .serviceSubCategories.subServiceCategoryReviews!.length,
                itemBuilder: (context, index) {
                  SubServiceCategoryReviews review = widget
                      .serviceSubCategories.subServiceCategoryReviews![index];
                  return ListTile(
                    title: Text(
                      review.customerName,
                      style: myTextStylefontsize12WhiteW300,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ' Review : ${review.customerReview}',
                          style: myTextStylefontsize12WhiteW300,
                        ),
                        Text(
                          ' OrderId : ${review.customerOrderId}',
                          style: myTextStylefontsize12WhiteW300,
                        ),
                      ],
                    ),
                    trailing: Text(
                      review.customerRating,
                      style: myTextStylefontsize12WhiteW300,
                    ),
                    leading: Icon(
                      Ionicons.person_circle_outline,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
