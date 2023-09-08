import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../Successful/Booking Successful/Components/body.dart';

class BookingSuccessfulScreen extends StatelessWidget {
  const BookingSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0.0,
      ),
      backgroundColor: green,
      body: Body(),
    );
  }
}
