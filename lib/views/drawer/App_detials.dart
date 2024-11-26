import 'package:flutter/material.dart';

class AppDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Heading
            Text(
              'Welcome to My Music App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 15, 15, 15),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            
            // Description Section
            Text(
              'My Music App is designed to provide the ultimate music experience. Whether you are looking to discover new songs, create playlists, or enjoy music from your favorite artists, this app brings everything to your fingertips.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),

            // Features Section
            Text(
              'Features:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 14, 14, 14),
              ),
            ),
            SizedBox(height: 10),
            Text(
              '• Discover new songs and albums.\n'
              '• Create and manage your own playlists.\n'
              '• Stream music with high-quality audio.\n'
              '• Search for your favorite artists and songs.\n'
              '• Enjoy personalized recommendations based on your listening history.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 30),

            // Footer or Additional Info Section
            Text(
              'Version: 1.0.0\n'
              'Developed by: zyn\n'
              'Email: support@musicapp.com\n'
              'Follow us on Social Media: @MyMusicApp',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
