// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';

import '../../../../Components/pinned_button.dart';
import '../../../../Components/profile_item.dart';
import '../../../../Components/profile_item_dropdown.dart';
import '../../../../constants.dart';
import '../../../../main.dart';
import '../../../Successful/Booking Successful/booking_successful_screen.dart';
import 'momo_listView.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final phoneNumberController = TextEditingController();
  final confirmNumberController = TextEditingController();
  final amountController = TextEditingController();
  final referenceController = TextEditingController();

  @override
  void dispose() {
    phoneNumberController.dispose();
    confirmNumberController.dispose();
    amountController.dispose();
    referenceController.dispose();
    super.dispose();
  }

  Future momoPayment() async {
    Charge charge = Charge()
      ..amount = (int.parse(amountController.text) * 100)
      // ..phoneNumber = phoneNumberController.text
      ..email = 'pjaiitey.dev@gmail.com'
      ..reference = referenceController.text.trim()
      ..accessCode = ''
      ..addParameter('Mobile Number', phoneNumberController.text)
      ..currency = "GHS"
      ..putCustomField("payment_type", "mobile_money");

    charge.putCustomField("payment_type", "mobile_money");

    try {
      CheckoutResponse response =
          await plugin.checkout(context, charge: charge);

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

  bool numberCheck() {
    if (phoneNumberController.text == confirmNumberController.text) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.5,
                  vertical: 15,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
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
                    Container(
                      constraints: BoxConstraints(minHeight: 170.26),
                      width: 359,
                      decoration: BoxDecoration(
                          color: sectionColor,
                          borderRadius: BorderRadius.circular(13)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 23, vertical: 22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Image.asset('assets/images/mobile_money.png',
                                height: 87, width: 138.13),
                          ),
                          ChargePerItem(
                            isReadOnly: false,
                            isChargeRate: true,
                            hintText: 'MTN Mobile Money',
                            title: 'Options',
                            listName: momoListOptions,
                            width: 310,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text(
                        'Transactional Details',
                        style: TextStyle(
                          color: black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 9),
                    Container(
                      constraints: BoxConstraints(minHeight: 412),
                      width: 359 * screenWidth,
                      decoration: BoxDecoration(
                          color: sectionColor,
                          borderRadius: BorderRadius.circular(13)),
                      padding: EdgeInsets.symmetric(
                          horizontal: 23 * screenWidth,
                          vertical: 22 * screenHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ProfileItem(
                            isReadOnly: false,
                            controller: phoneNumberController,
                            inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10)
                            ],
                            title: "Recipient's Number",
                            hintText: 'Enter number here...',
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 20 * screenHeight),
                          ProfileItem(
                            isReadOnly: false,
                            controller: confirmNumberController,
                            inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10)
                            ],
                            title: "Confirm Number",
                            hintText: "Re-enter recipient's number here...",
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 20 * screenHeight),
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
                          SizedBox(height: 20 * screenHeight),
                          ProfileItem(
                            isReadOnly: false,

                            controller: referenceController,
                            inputFormatter: [
                              FilteringTextInputFormatter.deny('!@#\$%^&*()')
                            ], // Deny specific characters

                            title: "Reference",
                            hintText: "Enter reference...",
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: 1,
          ),
        ),
        PinnedButton(
          function: momoPayment,
          // () {
          // if (numberCheck()) {

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => BookingSuccessfulScreen(),
          //     ));
          // } else {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //         duration: Duration(seconds: 2),
          //         backgroundColor: Colors.black45,
          //         behavior: SnackBarBehavior.floating,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(20)),
          //         content: Center(
          //           child: Text(
          //             "Recipient's number and confirm number are not equal. Try again.",
          //             style: TextStyle(height: 1.3),
          //             textAlign: TextAlign.center,
          //           ),
          //         )),
          //   );
          // }
          // },
          screen: BookingSuccessfulScreen(),
          isIconPresent: true,
        ),
      ],
    );
  }
}
