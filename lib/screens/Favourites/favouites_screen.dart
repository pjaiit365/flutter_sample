import 'package:flutter/material.dart';
import 'package:pet_life_gh/Components/bottom_nav_bar.dart';
import 'package:pet_life_gh/enum.dart';
import 'package:pet_life_gh/screens/Favourites/Components/body.dart';
import 'package:pet_life_gh/screens/My%20Cart/cart_page.dart';

import '../../Components/custom_drawer.dart';
import '../../constants.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        title: Text(
          'PETLIFEGH',
          style: TextStyle(
            color: blue,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Body(),
      backgroundColor: white,
      bottomNavigationBar: BottomNavBar(selectedIcon: BottomNavState.favourite),
    );
  }
}
