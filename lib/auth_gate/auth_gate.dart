import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone/Login/Loginpage/Loginpage.dart';
import 'package:spotify_clone/views/home.dart';

class AuthGate extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, Snapshot) {
            if (Snapshot.hasData) {
              return HomeView();
            } else {
              return Loginpage();
            }
          }),
    );
  }
}
