// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pet_life_gh/Components/default_back_button.dart';
import 'package:pet_life_gh/constants.dart';
import 'package:pet_life_gh/screens/Add%20Featured%20Product/Component/body.dart';

class AddFeaturedProduct extends StatelessWidget {
  const AddFeaturedProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: DefaultBackButton(),
        title: Text(
          "Add Product",
          style:
              TextStyle(fontSize: 20, color: blue, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      backgroundColor: white,
      body: Body(),
    );
  }
}
