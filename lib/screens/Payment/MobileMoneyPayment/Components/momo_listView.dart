import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../Components/profile_item.dart';
import '../../../../Components/profile_item_dropdown.dart';
import '../../../../constants.dart';

class MomoListView extends StatelessWidget {
  const MomoListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                color: sectionColor, borderRadius: BorderRadius.circular(13)),
            padding: EdgeInsets.symmetric(horizontal: 23, vertical: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Image.asset('assets/images/mobile_money.png',
                      height: 87, width: 138.13),
                ),
                ChargePerItem(
                  // hintText: 'MTN Mobile Money',
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
            width: 359,
            decoration: BoxDecoration(
                color: sectionColor, borderRadius: BorderRadius.circular(13)),
            padding: EdgeInsets.symmetric(horizontal: 23, vertical: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ProfileItem(
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ],
                  title: "Recipient's Number",
                  hintText: 'Enter number here...',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                ProfileItem(
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ],
                  title: "Confirm Number",
                  hintText: "Re-enter recipient's number here...",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                ProfileItem(
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
  }
}
