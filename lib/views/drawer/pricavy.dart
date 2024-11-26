import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy & Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Title of the page
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // Introduction
            Text(
              'Welcome to My Music App! Your privacy is important to us. This privacy policy explains how we collect, use, and safeguard your data while you use our app.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),

            // Data Collection Section
            Text(
              '1. Data Collection',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We may collect the following information from you:\n'
              '• Personal information such as your name, email, and other details provided during account creation.\n'
              '• Usage data including how you interact with our app, the features you use, and the frequency of use.\n'
              '• Device information like your device type, operating system version, and IP address.\n',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),

            // Data Usage Section
            Text(
              '2. Data Usage',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We use your data for the following purposes:\n'
              '• To provide and maintain the app’s features.\n'
              '• To personalize your experience within the app.\n'
              '• To improve the functionality of our app by analyzing user interactions.\n'
              '• To send you notifications about updates, features, or promotions (with your consent).\n',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),

            // Data Protection Section
            Text(
              '3. Data Protection',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We take the security of your data seriously. We implement a variety of security measures to maintain the safety of your personal information. However, no method of transmission over the internet or method of electronic storage is 100% secure, and we cannot guarantee absolute security.\n',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),

            // Sharing Information Section
            Text(
              '4. Sharing Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We do not sell, trade, or rent your personal data to third parties. However, we may share information with third-party service providers who assist in operating our app or conducting business on our behalf, but they are obligated to keep this information confidential.\n',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),

            // User Rights Section
            Text(
              '5. Your Rights',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                
              ),
            ),
            SizedBox(height: 10),
            Text(
              'You have the right to:\n'
              '• Access the personal data we hold about you.\n'
              '• Request corrections to any inaccurate or incomplete information.\n'
              '• Request the deletion of your personal data, subject to certain limitations.\n'
              '• Opt-out of receiving promotional communications at any time.\n',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),

            // Changes to the Privacy Policy Section
            Text(
              '6. Changes to the Privacy Policy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We may update this privacy policy from time to time. When we make changes, we will post the updated policy on this page with a revised “Effective Date.” We encourage you to review this privacy policy periodically to stay informed about how we are protecting your data.\n',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),

            // Contact Information Section
            Text(
              '7. Contact Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                
              ),
            ),
            SizedBox(height: 10),
            Text(
              'If you have any questions or concerns about this privacy policy or our practices, please contact us at:\n'
              'Email: support@musicapp.com\n'
              'Phone: +91 9207846064\n',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
