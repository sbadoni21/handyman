import 'package:flutter/material.dart';

class PlusMemberShipScreen extends StatefulWidget {
  const PlusMemberShipScreen({Key? key}) : super(key: key);

  @override
  State<PlusMemberShipScreen> createState() => _PlusMemberShipScreenState();
}

class _PlusMemberShipScreenState extends State<PlusMemberShipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plus Membership'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Unlock Premium Features with Plus Membership',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Upgrade to Plus Membership and unlock exclusive features to enhance your experience with [Your App Name]. With Plus Membership, you\'ll enjoy a range of benefits designed to make your app usage more convenient and enjoyable.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20.0),
              // List of exclusive features
              _buildFeatureItem(
                'Ad-Free Experience',
                'Say goodbye to ads and enjoy uninterrupted usage of [Your App Name].',
              ),
              _buildFeatureItem(
                'Unlimited Access',
                'Gain unlimited access to all premium content, including exclusive articles, videos, and more.',
              ),
              _buildFeatureItem(
                'Priority Support',
                'Get priority customer support from our dedicated team of experts to address any questions or issues you may have.',
              ),
              _buildFeatureItem(
                'Advanced Features',
                'Access advanced features and customization options to tailor your app experience to your preferences.',
              ),
              _buildFeatureItem(
                'Offline Mode',
                'Download content for offline viewing and access it anytime, anywhere, even without an internet connection.',
              ),
              const SizedBox(height: 20.0),
              const Text(
                'How to Upgrade:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                '1. Open the app and navigate to the Plus Membership page.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const Text(
                '2. Choose the subscription plan that best fits your needs: monthly, quarterly, or annually.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const Text(
                '3. Complete the payment process securely and start enjoying your Plus Membership benefits immediately.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Cancellation:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Not satisfied with your Plus Membership? You can cancel anytime hassle-free. Your subscription will remain active until the end of the billing period, and you\'ll still have access to all Plus Membership benefits until then.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Get Started Today:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  // Add navigation logic to the subscription page here
                },
                child: const Text(
                  'Upgrade to Plus Membership',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          description,
          style: const TextStyle(
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
