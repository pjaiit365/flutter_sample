import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pet_life_gh/Components/bottom_nav_bar.dart';
import 'package:pet_life_gh/constants.dart';
import 'package:pet_life_gh/enum.dart';
import 'package:pet_life_gh/screens/My%20Cart/component/body.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: blue,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: blue,
          ),
        ),
        backgroundColor: white,
      ),
      body: Body(),
      backgroundColor: white,
    );
  }
}
