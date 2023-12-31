import 'package:flutter/material.dart';

import '../constants.dart';
import '../screens/Successful/Booking Successful/booking_successful_screen.dart';

class PinnedButton extends StatelessWidget {
  Function? function;
  IconData icon;
  Widget screen;
  String buttonText;
  bool isIconPresent;
  PinnedButton({
    this.icon = Icons.check_circle_rounded,
    Key? key,
    this.buttonText = 'Proceed',
    this.isIconPresent = false,
    this.screen = const BookingSuccessfulScreen(),
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          function!();
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => screen,
          //     ));
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
          child: isIconPresent
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Icon(icon, color: white),
                      SizedBox(width: 9),
                      Text(
                        buttonText,
                        style: TextStyle(
                          color: white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ])
              : Center(
                  child: Text(
                  buttonText,
                  style: TextStyle(
                    color: white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                )),
        ),
      ),
    );
  }
}
