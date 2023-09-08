import 'package:flutter/material.dart';

import '../../../Components/default_back_button.dart';
import '../../../constants.dart';
import '../../Payment/CreditCardPayment/Components/body.dart';

class CreditCardPayment extends StatelessWidget {
  const CreditCardPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(),
        title: Text(
          'Credit/Debit Card Transactions',
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: white,
        elevation: 0.0,
      ),
      body: Body(),
      backgroundColor: white,
    );
  }
}
