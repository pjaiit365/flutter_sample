import 'package:flutter/material.dart';
import 'package:pet_life_gh/enum.dart';
import 'package:pet_life_gh/screens/Dashboard/dashboard_screen.dart';
import 'package:pet_life_gh/screens/Favourites/favouites_screen.dart';
import 'package:pet_life_gh/screens/Home2/home_screen2.dart';
import 'package:pet_life_gh/screens/Log%20In/log_in_screen.dart';
import 'package:pet_life_gh/screens/My%20Cart/cart_page.dart';
import 'package:pet_life_gh/screens/Settings/settings_screen.dart';
import 'package:pet_life_gh/screens/Vet/vet_screen.dart';

import '../constants.dart';

class BottomNavBar extends StatelessWidget {
  final Enum selectedIcon;
  const BottomNavBar({
    Key? key,
    required this.selectedIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      color: blue,
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeSreen2(),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.home,
                  color: BottomNavState.home == selectedIcon ? green : grey,
                  size: 20,
                ),
                Text(
                  "Home",
                  style: TextStyle(
                    color: BottomNavState.home == selectedIcon ? green : grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavouritesScreen(),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite,
                  color:
                      BottomNavState.favourite == selectedIcon ? green : grey,
                  size: 20,
                ),
                Text(
                  "Favorites",
                  style: TextStyle(
                    color:
                        BottomNavState.favourite == selectedIcon ? green : grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopify,
                  color: BottomNavState.shop == selectedIcon ? green : grey,
                  size: 23,
                ),
                Text(
                  "Shop",
                  style: TextStyle(
                    color: BottomNavState.shop == selectedIcon ? green : grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VetScreen(),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: BottomNavState.vet == selectedIcon ? green : grey,
                ),
                Text(
                  "Vet",
                  style: TextStyle(
                    color: BottomNavState.vet == selectedIcon ? green : grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.settings,
                  color: BottomNavState.settings == selectedIcon ? green : grey,
                ),
                Text(
                  "settings",
                  style: TextStyle(
                    color:
                        BottomNavState.settings == selectedIcon ? green : grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
