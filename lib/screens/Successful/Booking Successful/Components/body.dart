import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: SvgPicture.asset(
            'assets/icons/repair_illustration.svg',
            height: 203,
            width: 215.56,
          ),
        ),
        SizedBox(height: 23),
        Text(
          'Successful Booking!',
          style: TextStyle(
              color: white, fontSize: 30, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 47.0),
          child: Text(
            'An offer has been sent to the handyman. You will be notified '
            'of the status of the offer. \nThank You.',
            style: TextStyle(color: white, fontSize: 17),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 86),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 64,
            width: 335,
            decoration: BoxDecoration(
              color: green,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 2, color: white),
            ),
            alignment: Alignment.center,
            child: Container(
              height: 44,
              width: 315,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  'Great!',
                  style: TextStyle(
                      color: green, fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
