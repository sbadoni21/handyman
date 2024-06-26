import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/models/bookings_model.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/notifier/user_state_notifier.dart';
import 'package:handyman/screens/home_screen.dart';
import 'package:handyman/services/data/mybookings_service.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:handyman/widgets/customappbar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class MyBookingsDetailsPage extends ConsumerStatefulWidget {
  final BookingModel booking;

  const MyBookingsDetailsPage({required this.booking});

  @override
  _MyBookingsDetailsPageState createState() => _MyBookingsDetailsPageState();
}

class _MyBookingsDetailsPageState extends ConsumerState<MyBookingsDetailsPage> {
  TextEditingController _reviewController = TextEditingController();
  bool addedReview = false;
  List<Contact>? _contacts;

  Future<void> _getContacts() async {
    if (!mounted) {
      return;
    }

    if (await Permission.contacts.request().isGranted) {
      List<Contact> contacts = (await ContactsService.getContacts()).toList();

      if (!mounted) {
        return;
      }

      setState(() {
        _contacts = contacts;
      });
    }
  }

  String referralMessage(String booking) {
    return 'Hey, check out HomeHero for your home. My Booking Id: $booking  ';
  }

  void sendSms(String referralCode, String phoneNumber) async {
    String encodedMessage = Uri.encodeComponent(referralMessage(
      widget.booking.bookingUID,
    ));

    String smsUrl = 'sms:$phoneNumber?body=$encodedMessage';

    if (await canLaunch(smsUrl)) {
      await launch(smsUrl);
    } else {
      throw 'Could not launch $smsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Booking Details', style: myTextStylefontsize19Black),
                    IconButton(
                        onPressed: () {
                          _buildBottom();
                        },
                        icon: const Icon(Icons.share))
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 0,
                ),
                const SizedBox(height: 20),
                _buildDetailRow('Service Name', widget.booking.serviceName),
                _buildDetailRow(
                    'Provider Name', widget.booking.serviceProviderName),
                _buildDetailRow('Service Subcategory',
                    widget.booking.serviceSubCategoryName),
                _buildDetailRow('Service Cost ₹', widget.booking.serviceCost),
                _buildDetailRow(
                    'Service Location', widget.booking.serviceLocation),
                _buildDetailRow('Review', widget.booking.review),
                _buildDetailRow('Distance', '${widget.booking.distance} km'),
                _buildDetailRow(
                    'Time of Booking', widget.booking.timeOfBooking.toString()),
                SizedBox(height: 20),
                const Divider(
                  color: Colors.black,
                  thickness: 0,
                ),
                SizedBox(height: 20),
                _buildReviewSection(),
              ],
            ),
          ),
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
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add Your Review',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _reviewController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Write your review here...',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white),
              onPressed: () async {
                String enteredReview = _reviewController.text;
                if (enteredReview.isNotEmpty) {
                  try {
                    await ref
                        .watch(myBookingsProvider)
                        .addReview(widget.booking.bookingUID, enteredReview);
                    setState(() {
                      addedReview = true;
                      widget.booking.review = enteredReview;
                    });
                    _showDialog(context);
                    _reviewController.clear();
                  } catch (e) {
                    SnackBar(
                      content: Text("Error, Please try again"),
                    );
                  }
                }
              },
              child: Text('Submit Review'),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _buildBottom() async {
    User? user = ref.read(userStateNotifierProvider);

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: 400,
          child: Column(
            children: [
              const Text(
                'Contacts',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _contacts!.length,
                  itemBuilder: (context, index) {
                    String phoneNumber =
                        _contacts![index].phones!.first.value ?? '';
                    return ListTile(
                      title: Text(_contacts![index].displayName ?? ''),
                      subtitle: Text(
                        _contacts![index]
                                .phones
                                ?.map((e) => e.value)
                                .toList()
                                .join(', ') ??
                            '',
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          sendSms(user!.referralCode, phoneNumber);
                        },
                        icon: const Icon(Ionicons.share),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          titleTextStyle: myTextStylefontsize16Black,
          title: Text('Thankyou for your feedback'),
          content: Lottie.asset('assets/lottie/thankyou.json'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }
}
