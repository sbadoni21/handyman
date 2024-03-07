import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/models/user.dart';
import 'package:handyman/screens/account_screen.dart';
import 'package:handyman/utils/app_colors.dart';
import 'package:flutter/services.dart';

class RewardScreen extends ConsumerStatefulWidget {
  const RewardScreen({super.key});

  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends ConsumerState<RewardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          _buildTop(),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text(
              'Earn Coins by Refer',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          _buildCopytoClipboard(),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Widget _buildTop() {
    return Center(
      child: Container(
        height: 150,
        width: 200,
        decoration: BoxDecoration(
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
                  style: TextStyle(color: Colors.white70),
                  controller: TextEditingController(text: user!.referralCode),
                  readOnly: true,
                  decoration: InputDecoration(
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
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.transparent), 
                overlayColor: MaterialStateProperty.all<Color>(
                    Colors.transparent),
                elevation:
                    MaterialStateProperty.all<double>(0),
              ),
              onPressed: () {
                _copyToClipboard('referralCode', context);
              },
              child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  child: Icon(Icons.copy)),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.transparent), 
                overlayColor: MaterialStateProperty.all<Color>(
                    Colors.transparent),
                elevation:
                    MaterialStateProperty.all<double>(0),
              ),
              onPressed: () {
                _buildBottom();
              },
              child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  child: Icon(Icons.share)),
            ),
          ],
        ),
      ),
    );
  }

  void _copyToClipboard(String text, BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Referral code copied to clipboard'),
      ),
    );
  }

  void _buildBottom() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          height: 400,
          child: Center(
            child: Text(
              'This is a bottom sheet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
