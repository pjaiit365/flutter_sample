import 'package:flutter/material.dart';
import 'package:pet_life_gh/Components/bottom_nav_bar.dart';
import 'package:pet_life_gh/constants.dart';
import 'package:pet_life_gh/screens/My%20Cart/cart_page.dart';
import 'package:pet_life_gh/screens/Settings/component/body.dart';

import '../../Components/custom_drawer.dart';
import '../../enum.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
      backgroundColor: white,
      body: Body(),
      bottomNavigationBar: BottomNavBar(selectedIcon: BottomNavState.settings),
    );
  }
}
