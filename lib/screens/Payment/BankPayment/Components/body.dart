// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import '../../../../Components/profile_item.dart';
import '../../../../Components/profile_item_dropdown.dart';
import '../../../../Services/read_data.dart';
import '../../../../constants.dart';
import '../../../../main.dart';
import '../../../My Cart/component/body.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isSaveDetailsClicked = false;

  final emailController = TextEditingController();
  final amountController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    amountController.text = totalPrice.toString();
    ReadData().getUser().then((_) {
      emailController.text = allUsers[0].email;
    });
    expertiseHintText = 'N/A';
    super.initState();
  }

  Future creditCardPayment() async {
    try {
      Charge charge = Charge()
        ..amount = (int.parse(amountController.text) * 100)
        ..accessCode = '057'
        ..currency = 'GHS'
        // ..card = PaymentCard(
        //   number: cardNumberController.text,
        //   cvc: cvvController.text,
        //   expiryMonth: int.parse(expiryController.text[0].toString() +
        //       expiryController.text[1].toString()),
        //   expiryYear: int.parse(expiryController.text[2].toString() +
        //       expiryController.text[3].toString()),
        // )
        ..email = emailController.text.trim();

      CheckoutResponse response = await plugin.checkout(
        context,
        charge: charge,
        logo: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('asset/images/logo.png'),
            ),
          ),
        ),
        method: CheckoutMethod.bank,
        hideEmail: true,
      );

      if (response.status) {
        if (mounted) {}
        print('Payment successful');
      } else {
        print('Payment failed: ${response.message}');
      }
    } on PaystackException catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Payment Error'.toUpperCase(),
                style: TextStyle(color: green, fontSize: 17),
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: Text(
              '$error\nTry again later.',
              style: TextStyle(
                height: 1.4,
                fontSize: 16,
                color: black,
              ),
            ),
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Error'.toUpperCase(),
                style: TextStyle(color: green, fontSize: 17),
              ),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: Text(
              '$e\nTry again later.',
              style: TextStyle(
                height: 1.4,
                fontSize: 16,
                color: black,
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.5,
                vertical: 15,
              ),
              child: ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text(
                          'Service Provider',
                          style: TextStyle(
                            color: black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 9),
                      Center(
                        child: Container(
                          constraints: BoxConstraints(minHeight: 170.26),
                          width: 359,
                          decoration: BoxDecoration(
                              color: sectionColor,
                              borderRadius: BorderRadius.circular(13)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 23, vertical: 22),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Image.asset(
                                    'asset/images/bank_transfer.png',
                                    height: 87,
                                    width: 138.13),
                              ),
                              ChargePerItem(
                                // hintText: 'MTN Mobile Money',
                                title: 'Options',
                                listName: bankList,
                                width: 310,
                              ),
                              SizedBox(height: 20),
                              ProfileItem(
                                isReadOnly: false,
                                controller: amountController,
                                inputFormatter: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(3)
                                ],
                                title: "Amount",
                                hintText: "Enter amount here...",
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 20),
                              ProfileItem(
                                isReadOnly: false,
                                controller: emailController,
                                inputFormatter: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z0-9.@]')),
                                  LengthLimitingTextInputFormatter(35)
                                ],
                                title: "Email Address",
                                hintText: "Enter email address here...",
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                    ],
                  );
                },
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () async {
              await creditCardPayment();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => BookingSuccessfulScreen(),
              //   ),
              // );
            },
            child: Container(
              height: 56,
              width: double.infinity,
              decoration: BoxDecoration(
                color: green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                border: Border.all(color: white, width: 0.5),
              ),
              child: Center(
                  child: Text(
                'Proceed',
                style: TextStyle(
                  color: white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              )),
            ),
          ),
        ),
      ],
    );
  }
}
