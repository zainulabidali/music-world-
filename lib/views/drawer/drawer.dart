import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone/Login/Loginpage/Loginpage.dart';
import 'package:spotify_clone/Login/Loginpage/auth_servies.dart';
import 'package:spotify_clone/views/drawer/App_detials.dart';
import 'package:spotify_clone/views/drawer/pricavy.dart';
import 'package:spotify_clone/views/drawer/settingsPage.dart';

class CustomDrawer extends StatelessWidget {
  final AuthServies authServies = AuthServies();

  @override
  Widget build(BuildContext context) {
    // Get current user from AuthServies
    User? currentUser = authServies.getCurrentUser();

    // Fallback text if no user is logged in
    String userEmail = currentUser?.email ?? "xxxxxxxx";
    String userName = currentUser?.displayName ?? "";

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // User account header
          UserAccountsDrawerHeader(
            accountEmail: Text(userEmail),
            accountName: Text(userName),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:
                  AssetImage("assets/profil_img-removebg-preview.png"),
              child: Icon(Icons.person, color: Colors.blue, size: 40),
            ),
            decoration:
                BoxDecoration(color: const Color.fromARGB(255, 212, 191, 0)),
          ),
          // Home menu item
          ListTile(
            leading: Icon(Icons.music_note),
            title: Text("Music PlayList"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          // Settings menu item
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ),
          // Music Player menu item
          ListTile(
            leading: Icon(Icons.description),
            title: Text("App Detials"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AppDetailsPage()));
            },
          ),

          // Privacy & Policy menu item
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text("Privacy & Policy"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicyPage()));
            },
          ),
          Divider(),
          // Logout menu item
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: () async {
              await authServies.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Loginpage()));
            },
          ),
        ],
      ),
    );
  }
}
