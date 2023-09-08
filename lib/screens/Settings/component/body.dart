import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_life_gh/constants.dart';
import 'package:pet_life_gh/screens/Log%20In/log_in_screen.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          FirebaseAuth.instance.signOut();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LogInScreen()),
              (route) => false);
        },
        child: Container(
          height: 65,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.red.shade100,
          ),
          child: Center(
            child: Text(
              'Logout',
              style: TextStyle(
                color: Colors.red.shade700,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
