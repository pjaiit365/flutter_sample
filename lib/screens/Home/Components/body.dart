import 'package:flutter/material.dart';
import 'package:pet_life_gh/screens/Sign%20Up/sign_up_screen.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 340,
            width: double.infinity,
            decoration: BoxDecoration(
              color: blue,
            ),
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 160),
                Text(
                  "Let's make your animal feel at home",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: white,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  "Changing peoples perspective about pets by making them aware that pet’s life matters through our expertise",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
              child: Container(
                height: 55,
                width: 350,
                decoration: BoxDecoration(
                  color: green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.mobile_friendly),
                    SizedBox(width: 12),
                    Text(
                      "Continue with number",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: black,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: 1,
                      width: 110,
                      color: grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      " Or Login with",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: borderColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 1,
                      width: 110,
                      color: grey,
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 55,
                      width: 168,
                      decoration: BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Google",
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      width: 168,
                      decoration: BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'asset/icon/apple.png',
                              height: 16,
                              width: 18,
                            ),
                            Text(
                              "facebook",
                              style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
