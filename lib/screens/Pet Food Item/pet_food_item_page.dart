// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pet_life_gh/Components/default_back_button.dart';
import 'package:pet_life_gh/Services/read_data.dart';
import 'package:pet_life_gh/constants.dart';
import 'package:pet_life_gh/screens/Dashboard/Components/pet_food_item.dart';
import 'package:pet_life_gh/screens/My%20Cart/cart_page.dart';
import 'package:pet_life_gh/screens/Pet%20Food%20Item/Components/body.dart';

class PetFoodItemPage extends StatefulWidget {
  const PetFoodItemPage({super.key});

  @override
  State<PetFoodItemPage> createState() => _PetFoodItemPageState();
}

int categoryActiveIndex = 0;

class _PetFoodItemPageState extends State<PetFoodItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        leading: DefaultBackButton(),
        title: Text(
          allProducts[selectedProductIndex].title,
          style: TextStyle(color: blue, fontSize: 17),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
            icon: Icon(
              Icons.shopping_cart_rounded,
              color: blue,
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Body(),
    );
  }
}
