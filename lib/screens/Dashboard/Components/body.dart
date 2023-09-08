// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pet_life_gh/Services/read_data.dart';
import 'package:pet_life_gh/screens/Dashboard/Components/petclothingitem.dart';

import '../../../constants.dart';
import 'dashboard_carousel.dart';
import 'dashboard_tab.dart';
import 'pet_food_item.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedTabIndex = 0;
  void OnTabSelected(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          DashboardCarousel(),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 30),
            child: SizedBox(
              height: 47,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return DashboardTabs(
                    index: index,
                    onTabSelected: OnTabSelected,
                    selectedTabIndex: selectedTabIndex,
                    title: tabNames[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 22);
                },
                itemCount: tabNames.length,
              ),
            ),
          ),
          tabNames[selectedTabIndex] == 'Pet Products'
              ? FutureBuilder(
                  future: ReadData().getSelectedProducts('Pet Products'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return allProducts.isEmpty
                          ? Center(
                              child: Text(
                                  'No ${tabNames[selectedTabIndex]} available'),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 21.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Pet Food',
                                        style: TextStyle(
                                          color: blue,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              OnTabSelected(2);
                                            },
                                            child: Text(
                                              'See More',
                                              style: TextStyle(
                                                color: grey,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Icon(Icons.arrow_forward,
                                              color: grey, size: 18),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: SizedBox(
                                    height: 190,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return allProducts[index].category ==
                                                'Pet Food'
                                            ? PetFoodItem(
                                                isItemFavourite:
                                                    allProducts[index]
                                                        .favourite,
                                                price: allProducts[index].price,
                                                title: allProducts[index].title,
                                                image: allProducts[index].image,
                                                index: index,
                                              )
                                            : SizedBox();
                                      },
                                      itemCount: allProducts.length,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 21),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Pet Clothing",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: blue,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              OnTabSelected(1);
                                            },
                                            child: Text(
                                              "See more",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: grey,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: grey,
                                            size: 18,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: SizedBox(
                                    height: 190,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return allProducts[index].category ==
                                                'Pet Clothing'
                                            ? PetClothingItem(
                                                isItemFavourite:
                                                    allProducts[index]
                                                        .favourite,
                                                index: index,
                                                title: allProducts[index].title,
                                                image:
                                                    allProducts[index].image[0],
                                                price: allProducts[index].price,
                                              )
                                            : SizedBox();
                                      },
                                      itemCount: allProducts.length,
                                    ),
                                  ),
                                ),
                              ],
                            );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Center(child: CircularProgressIndicator());
                  })
              : FutureBuilder(
                  future: ReadData()
                      .getSelectedProducts(tabNames[selectedTabIndex]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return allProducts.isEmpty
                          ? Center(
                              child: Text(
                                  'No ${tabNames[selectedTabIndex]} available'),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 18.0),
                                  child: Text(
                                    tabNames[selectedTabIndex],
                                    style: TextStyle(
                                      color: blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: GridView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: allProducts.length,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2),
                                    itemBuilder: (context, index) {
                                      return PetFoodItem(
                                        isItemFavourite:
                                            allProducts[index].favourite,
                                        price: allProducts[index].price,
                                        title: allProducts[index].title,
                                        image: allProducts[index].image,
                                        index: index,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
        ],
      ),
    );
  }
}
