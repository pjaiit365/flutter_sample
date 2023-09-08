import 'package:flutter/material.dart';
import '../../../Components/default_back_button.dart';
import '../../../constants.dart';
import '../../Payment/BankPayment/Components/body.dart';

class BankPayment extends StatelessWidget {
  const BankPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(),
        title: Text(
          'Bank Transfer',
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
