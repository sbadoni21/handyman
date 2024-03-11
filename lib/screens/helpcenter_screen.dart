import 'package:flutter/material.dart';
import 'package:handyman/utils/app_colors.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Help Center'),
        ),
        body:  Container(
          padding: const EdgeInsets.all(16.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Our Help Center',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'At Handyman, we\'re committed to providing you with the best experience possible. If you have any questions or encounter any issues while using our app, our Help Center is here to assist you. Below, you\'ll find answers to frequently asked questions and helpful resources to guide you through common tasks.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Frequently Asked Questions (FAQ)',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.0),
              // FAQ Dropdowns
              FAQDropdown(
                question: 'How do I create an account?',
                answer: 'To create an account, simply navigate to the sign-up page and follow the prompts to enter your information. Once you\'ve completed the sign-up process, you\'ll be able to access all of Handyman\'s features.',
              ),
              FAQDropdown(
                question: 'I forgot my password. How do I reset it?',
                answer: 'If you\'ve forgotten your password, you can reset it by visiting the password reset page. Enter the email associated with your account, and we\'ll send you instructions on how to reset your password.',
              ),
              FAQDropdown(
                question: 'How do I update my profile information?',
                answer: 'To update your profile information, go to the settings page within the app. From there, you\'ll be able to edit your name, email, and other account details.',
              ),
              SizedBox(height: 20.0),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'If you can\'t find the answer to your question in our Help Center, feel free to reach out to our support team for further assistance. You can contact us via email at support@handyman.com or through the in-app support chat.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQDropdown extends StatefulWidget {
  final String question;
  final String answer;

  const FAQDropdown({
    required this.question,
    required this.answer,
  });

  @override
  _FAQDropdownState createState() => _FAQDropdownState();
}

class _FAQDropdownState extends State<FAQDropdown> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
          child: Row(
            children: [
              Icon(
                _expanded ? Icons.arrow_drop_down : Icons.arrow_right,
                color: Colors.black,
              ),
              SizedBox(width: 10.0),
              Text(
                widget.question,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        _expanded
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  widget.answer,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
              )
            : SizedBox.shrink(),
        SizedBox(height: 10.0),
      ],
    );
  }
}
