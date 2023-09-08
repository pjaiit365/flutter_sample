// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pet_life_gh/screens/Dashboard/Components/pet_food_item.dart';
import 'package:pet_life_gh/screens/Dashboard/Components/petclothingitem.dart';

import '../../../Services/read_data.dart';
import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ReadData().getFavourites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    GridView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: allProducts.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return PetFoodItem(
                          isItemFavourite: allProducts[index].favourite,
                          price: allProducts[index].price,
                          title: allProducts[index].title,
                          image: allProducts[index].image,
                          index: index,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
