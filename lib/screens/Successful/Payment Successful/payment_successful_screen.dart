import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../Successful/Payment Successful/Components/body.dart';

class PaymentSuccessfulScreen extends StatelessWidget {
  const PaymentSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        elevation: 0.0,
        actions: [
          SizedBox(width: 12 * screenWidth),
        ],
      ),
      backgroundColor: green,
      body: Body(),
    );
  }
}
