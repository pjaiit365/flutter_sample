// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../../../Components/payment_option_item.dart';
import '../../../../constants.dart';
import '../../BankPayment/bank_payment.dart';
import '../../CreditCardPayment/credit_card_payment.dart';
import '../../MobileMoneyPayment/mobile_money_payment.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 27),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(
              'Choose your payment method',
              style: TextStyle(
                color: black,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 74),
          Center(
            child: PaymentOptionItem(
              logoLocation: 'asset/images/credit_card.png',
              optionTitle: 'Credit/Debit \nCard',
              press: CreditCardPayment(),
            ),
          ),
          SizedBox(height: 25),
          Center(
            child: Text(
              'OR',
            ),
          ),
          SizedBox(height: 25),
          Center(
            child: PaymentOptionItem(
              logoLocation: 'asset/images/bank_transfer.png',
              optionTitle: 'Bank Transfer',
              press: BankPayment(),
            ),
          ),
        ],
      ),
    );
  }
}
