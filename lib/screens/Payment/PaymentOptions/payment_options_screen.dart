import 'package:flutter/material.dart';
import '../../../Components/default_back_button.dart';
import '../../../constants.dart';
import '../../Payment/PaymentOptions/Components/body.dart';

class PaymentOptionsScreen extends StatelessWidget {
  const PaymentOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(),
        elevation: 0.0,
        title: Text(
          'Payment',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: white,
      ),
      backgroundColor: white,
      body: Body(),
    );
  }
}
