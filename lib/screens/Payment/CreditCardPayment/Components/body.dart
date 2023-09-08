// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:pet_life_gh/Services/read_data.dart';
import 'package:pet_life_gh/screens/wrapper.dart';

import '../../../../Components/profile_item.dart';
import '../../../../Components/profile_item_dropdown.dart';
import '../../../../constants.dart';
import '../../../../main.dart';
import '../../../My Cart/component/body.dart';
import '../../../Successful/Payment Successful/payment_successful_screen.dart';

String secretKey = 'sk_test_adbb448fcceee5ccd4a07c19a5ac2195e9ea9daf';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isSaveDetailsClicked = false;

  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();
  final amountController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    cardNumberController.dispose();
    cvvController.dispose();
    expiryController.dispose();
    amountController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    ReadData().getUser().then((_) {
      emailController.text = allUsers[0].email;
      amountController.text = totalPrice.toString();
    });

    expertiseHintText = 'N/A';
    super.initState();
  }

  Future removeCartItems() async {
    final document = await FirebaseFirestore.instance
        .collection('Cart')
        .where('User ID', isEqualTo: loggedInUserId)
        .get();
    final docID = document.docs.single.id;
    await FirebaseFirestore.instance.collection('Cart').doc(docID).delete();
  }

  Future creditCardPayment() async {
    try {
      Charge charge = Charge()
        ..bearer = Bearer.Account
        ..amount = (int.parse(amountController.text) * 100)
        ..reference = '${Timestamp.now()}'
        ..currency = 'GHS'
        ..card = PaymentCard(
          number: cardNumberController.text,
          cvc: cvvController.text,
          expiryMonth: int.parse(expiryController.text[0].toString() +
              expiryController.text[1].toString()),
          expiryYear: int.parse(expiryController.text[2].toString() +
              expiryController.text[3].toString()),
        )
        ..email = emailController.text.trim();

      CheckoutResponse response = await plugin.checkout(
        context,
        charge: charge,
        logo: Container(
          height: 70 * screenHeight,
          width: 70 * screenWidth,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('asset/images/logo.png'),
            ),
          ),
        ),
        method: CheckoutMethod.card,
        hideEmail: true,
      );

      if (response.status) {
        if (mounted) {}
        print('Payment successful');
        print(response.status.toString());

        removeCartItems().then((_) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentSuccessfulScreen(),
              ),
              (route) => false);
        });
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
                horizontal: screenWidth * 15.5,
                vertical: 15 * screenHeight,
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
                        padding: EdgeInsets.only(left: screenWidth * 14.0),
                        child: Text(
                          'Service Provider',
                          style: TextStyle(
                            color: black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 9 * screenHeight),
                      Center(
                        child: Container(
                          constraints: BoxConstraints(minHeight: 170.26),
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
                              Center(
                                child: Image.asset(
                                    'asset/images/credit_card.png',
                                    height: 87 * screenHeight,
                                    width: 138.13 * screenWidth),
                              ),
                              ChargePerItem(
                                // hintText: 'MTN Mobile Money',
                                title: 'Options',
                                listName: creditCardList,
                                width: 310,
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
                      SizedBox(height: 25 * screenHeight),
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 14.0),
                        child: Text(
                          'Card Details',
                          style: TextStyle(
                            color: black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 9 * screenHeight),
                      Center(
                        child: Container(
                          constraints: BoxConstraints(minHeight: 280),
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
                                controller: cardNumberController,
                                isReadOnly: false,
                                inputFormatter: [
                                  // cardMask,
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(16),
                                ],
                                imageAssetLocation: 'asset/images/logo.png',
                                isCreditCard: true,
                                title: 'Card Number',
                                hintText: 'Enter card number here...',
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 20 * screenHeight),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ProfileItem(
                                    controller: expiryController,
                                    isReadOnly: false,
                                    inputFormatter: [
                                      // expiryMask,
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(4)
                                    ],
                                    title: 'Expiry Date',
                                    hintText: 'MM/YY',
                                    keyboardType: TextInputType.datetime,
                                    isWidthMax: false,
                                    width: 174,
                                  ),
                                  SizedBox(width: 20 * screenWidth),
                                  ProfileItem(
                                    controller: cvvController,
                                    isReadOnly: false,
                                    inputFormatter: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(4)
                                    ],
                                    isInputObscured: true,
                                    title: 'CVV/CVC',
                                    hintText: 'CVV/CVC',
                                    keyboardType: TextInputType.number,
                                    isWidthMax: false,
                                    width: 116,
                                  ),
                                ],
                              ),
                              SizedBox(height: 25 * screenHeight),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSaveDetailsClicked =
                                            !isSaveDetailsClicked;
                                      });
                                    },
                                    child: Container(
                                      height: 20 * screenHeight,
                                      width: 20 * screenWidth,
                                      decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(
                                            color: borderColor, width: 1),
                                      ),
                                      alignment: Alignment.center,
                                      child: isSaveDetailsClicked
                                          ? Container(
                                              height: 16 * screenHeight,
                                              width: 16 * screenWidth,
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                // borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                  child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 16,
                                              )),
                                            )
                                          : SizedBox(),
                                    ),
                                  ),
                                  SizedBox(width: 12 * screenWidth),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 2.0),
                                    child: Text(
                                      'Save card payment information to my \naccount for future transactions.',
                                      style: TextStyle(
                                        height: 1.2,
                                        color: black,
                                        fontSize: 15,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
              height: 56 * screenHeight,
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
