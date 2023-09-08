import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_life_gh/screens/Home2/home_screen2.dart';
import 'package:pet_life_gh/screens/Log%20In/log_in_screen.dart';

String loggedInUserId = '';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            loggedInUserId = FirebaseAuth.instance.currentUser!.uid;
            return HomeSreen2();
          } else {
            return LogInScreen();
          }
        },
      ),
    );
  }
}
