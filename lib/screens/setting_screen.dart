import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            ListTile(
              title: const Text('Notifications'),
              trailing: Switch(
                value: true, 
                onChanged: (value) {
                },
              ),
            ),
            ListTile(
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: false, 
                onChanged: (value) {
                },
              ),
            ),
            ListTile(
              title: const Text('Language'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
