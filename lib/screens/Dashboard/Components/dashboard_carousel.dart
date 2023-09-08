import 'package:flutter/material.dart';

import '../../../constants.dart';

class DashboardCarousel extends StatelessWidget {
  const DashboardCarousel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 140,
        width: 340,
        decoration: BoxDecoration(
          color: lightBlue,
          borderRadius: BorderRadius.circular(20),
          //To insert image into a container as the background image
          // image: DecorationImage(image: AssetImage(),fit: BoxFit.cover),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'New Collection',
              style: TextStyle(
                color: white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Detail',
                  style: TextStyle(
                    color: deepBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward,
                  color: deepBlue,
                  size: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
