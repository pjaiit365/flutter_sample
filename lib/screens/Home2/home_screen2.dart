// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pet_life_gh/Components/bottom_nav_bar.dart';
import 'package:pet_life_gh/constants.dart';
import 'package:pet_life_gh/enum.dart';
import 'package:pet_life_gh/screens/Add%20New%20Arrival/add_new_arrival.dart';
import 'package:pet_life_gh/screens/Home2/Component/body.dart';
import 'package:pet_life_gh/screens/My%20Cart/cart_page.dart';
import 'package:pet_life_gh/screens/Add%20Featured%20Product/Component/added_featured_product.dart'
    as drawer;

import '../../Components/custom_drawer.dart';
import '../../Components/drawer_tile.dart';
import 'Component/category_pop_up_item.dart';

class HomeSreen2 extends StatefulWidget {
  const HomeSreen2({Key? key}) : super(key: key);

  @override
  State<HomeSreen2> createState() => _HomeSreen2State();
}

int categoryActiveIndex = 0;

class _HomeSreen2State extends State<HomeSreen2> {
  void categoryPopUp() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              scrollable: true,
              title: Center(
                  child: Text(
                'Categories',
                style: TextStyle(
                  color: black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              )),
              contentPadding: EdgeInsets.all(0),
              insetPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 270,
                      width: double.infinity,
                      color: white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 30),
                          SizedBox(
                            height: 190,
                            width: 250,
                            child: CarouselSlider.builder(
                              itemBuilder: (context, index, i) {
                                return CategoryPopUpItem(
                                  categoryName: categoryNames[index],
                                  imageLocation: categoryPics[index],
                                );
                              },
                              itemCount: categoryNames.length,
                              options: CarouselOptions(
                                scrollDirection: Axis.horizontal,
                                viewportFraction: 0.7,
                                autoPlay: false,
                                enableInfiniteScroll: false,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.3,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    categoryActiveIndex = index;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 7,
                            width: 45,
                            child: ListView.separated(
                              itemCount: 4,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return SizedBox(width: 4);
                              },
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 7,
                                  width: 7,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (index == categoryActiveIndex)
                                        ? green
                                        : grey,
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(selectedIcon: BottomNavState.home),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
        title: Text(
          "PetsLifeGh",
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            icon: Icon(
              Icons.shopping_cart,
              color: blue,
            ),
          )
        ],
      ),
      drawer: CustomDrawer(),
      floatingActionButton: GestureDetector(
        onTap: categoryPopUp,
        child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: blue,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add,
              size: 35,
              color: green,
            )),
      ),
      body: Body(),
    );
  }
}
