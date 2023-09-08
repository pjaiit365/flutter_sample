// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_life_gh/Components/dashboard_item.dart';
import 'package:pet_life_gh/constants.dart';
import 'package:pet_life_gh/screens/Admin/Sub%20Screen/All%20Products/all_products_screen.dart';
import 'package:pet_life_gh/screens/wrapper.dart';

import '../../Admin/Sub Screen/Vets/vet_screen.dart';
import '../../My Cart/cart_page.dart';
import '../Sub Screen/Users/users_screen.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void logoutDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              title: Center(
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Are you sure you want to logout? ',
                    style: TextStyle(
                      height: 1.4,
                      color: black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 18),
                  Text(
                    'User: Administrator',
                    style: TextStyle(
                      height: 1.4,
                      color: blue,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        highlightColor: grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Ink(
                          height: 39,
                          width: 129,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: borderColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: chatGrey,
                        width: 10,
                        thickness: 10,
                      ),
                      InkWell(
                        highlightColor: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Wrapper(),
                              ),
                              (route) => false);
                        },
                        child: Ink(
                          height: 39,
                          width: 129,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text('Yes, Logout',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DashboardItem(
                        title: 'Users',
                        icon: Icons.person,
                        screen: UsersScreen(),
                      ),
                      DashboardItem(
                        title: 'Vets',
                        icon: Icons.person,
                        screen: VetScreen(),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DashboardItem(
                        title: 'All Products',
                        icon: Icons.add_box_rounded,
                        screen: AllProductScreen(),
                      ),
                      DashboardItem(
                        title: 'Cart',
                        icon: Icons.person,
                        screen: CartPage(),
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            logoutDialog();
          },
          child: Container(
            height: 58,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2), topRight: Radius.circular(2)),
              color: Colors.redAccent.withOpacity(0.2),
            ),
            child: Center(
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
