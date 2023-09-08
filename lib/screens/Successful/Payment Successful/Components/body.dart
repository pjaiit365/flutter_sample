// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_life_gh/screens/Dashboard/dashboard_screen.dart';
import '../../../../Services/read_data.dart';
import '../../../../constants.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int starsGiven = 0;
  final notesController = TextEditingController();
  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 80 * screenHeight,
          ),
          Center(
            child: Image.asset(
              'asset/images/payment.png',
              height: 203 * screenHeight,
              width: 215.56 * screenWidth,
            ),
          ),
          SizedBox(height: 23 * screenHeight),
          Text(
            'Successful Payment!',
            style: TextStyle(
                color: white, fontSize: 30, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10 * screenHeight),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 37.0 * screenWidth),
            child: Text(
              'Payment has been issued. You will receive a notification'
              'as we have debited your account. \nThank You.',
              style: TextStyle(color: white, fontSize: 17),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 86 * screenHeight),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(),
                  ));
            },
            child: Container(
              height: 64 * screenHeight,
              width: 335 * screenWidth,
              decoration: BoxDecoration(
                color: green,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 2, color: white),
              ),
              alignment: Alignment.center,
              child: Container(
                height: 44 * screenHeight,
                width: 315 * screenWidth,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'Done!',
                    style: TextStyle(
                        color: green,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
