// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pet_life_gh/screens/Add%20New%20Vet/add_vet_screen.dart';

import '../constants.dart';
import '../screens/Add Featured Product/Component/added_featured_product.dart';
import '../screens/Add New Arrival/add_new_arrival.dart';
import 'drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: white,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              CircleAvatar(
                backgroundImage: AssetImage('asset/images/pic_1.jpg'),
                radius: 35,
              ),
              SizedBox(height: 20),
              DrawerTile(
                screen: AddFeaturedProduct(),
                icon: Icons.add_home_work_sharp,
                title: 'Add Featured Product',
              ),
              SizedBox(height: 20),
              DrawerTile(
                screen: AddNewArrivals(),
                icon: Icons.add_home,
                title: 'Add New Arrivals',
              ),
              SizedBox(height: 20),
              DrawerTile(
                screen: AddVetScreen(),
                icon: Icons.add_home,
                title: 'Add New Veterinarian',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
