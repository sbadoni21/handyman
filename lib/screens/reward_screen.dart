import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/screens/account_screen.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class RewardScreen extends ConsumerStatefulWidget {
  const RewardScreen({super.key});

  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends ConsumerState<RewardScreen> {
  List<Contact>? _contacts;
  @override
  void initState() {
    super.initState();
    _getContacts();
  }

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
        print(_contacts!.first.phones!.first.value);
      });
    }
  }

  String referralMessage(String referralCode) {
    return 'Hey, check out HomeHero for your home. Use my referral code: $referralCode';
  }

  void sendSms(String referralCode, String phoneNumber) async {
    String encodedMessage = Uri.encodeComponent(referralMessage(referralCode));

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          _buildTop(),
          const SizedBox(
            height: 20.0,
          ),
          const Center(
            child: Text(
              'Earn Coins by Refer',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          _buildCopytoClipboard(),
          const SizedBox(
            height: 10.0,
          ),
          _buildText(),
        ],
      ),
    );
  }

  Widget _buildText() {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Invite friends, earn rewards!',
              style: myTextStylefontsize16white),
          SizedBox(height: 6.0),
          for (var i = 1; i <= 3; i++)
            Text('$i. ${_getDescription(i)}',
                style: myTextStylefontsize14WhiteW400),
          SizedBox(height: 10.0),
          Text('Start Referring', style: myTextStylefontsize16white),
          SizedBox(height: 8.0),
          Text('Share now, start earning!', style: myTextStylefontsize16white),
        ],
      ),
    );
  }

  String _getDescription(int index) {
    switch (index) {
      case 1:
        return 'Share your unique referral code.';
      case 2:
        return 'Earn rewards when friends sign up.';
      case 3:
        return 'Redeem rewards for offers.';
      default:
        return '';
    }
  }

  Widget _buildTop() {
    return Center(
      child: Container(
        height: 150,
        width: 200,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/rewards&refers.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildCopytoClipboard() {
    User? user = ref.watch(userProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0), // Add border here
        ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 60,
                width: 383,
                child: TextField(
                  style: const TextStyle(color: Colors.white70),
                  controller: TextEditingController(text: user!.referralCode),
                  readOnly: true,
                  decoration: const InputDecoration(
                    hintText: 'Enter referral code',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                overlayColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                elevation: MaterialStateProperty.all<double>(0),
              ),
              onPressed: () {
                _copyToClipboard(user!.referralCode, context);
              },
              child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  child: const Icon(Icons.copy)),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                overlayColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                elevation: MaterialStateProperty.all<double>(0),
              ),
              onPressed: () {
                _buildBottom();
              },
              child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  child: const Icon(Icons.share)),
            ),
          ],
        ),
      ),
    );
  }

  void _copyToClipboard(String text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Referral code copied to clipboard'),
      ),
    );
  }

  void _buildBottom() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        User? user = ref.read(userProvider);
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
                        _contacts!.first.phones!.first.value ?? '';
                    return ListTile(
                      title: Text(_contacts![index].displayName ?? ''),
                      subtitle: Text(_contacts![index]
                              .phones
                              ?.map((e) => e.value)
                              .toList()
                              .join(', ') ??
                          ''),
                      trailing: IconButton(
                        onPressed: () {
                          sendSms(user!.referralCode, phoneNumber);
                        },
                        icon: Icon(Ionicons.share),
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
}
