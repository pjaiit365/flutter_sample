// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_life_gh/Services/read_data.dart';
import 'package:pet_life_gh/screens/Pet%20Food%20Item/pet_food_item_page.dart';
import 'package:pet_life_gh/screens/wrapper.dart';

import '../../../constants.dart';

class PetFoodItem extends StatefulWidget {
  final String title;
  final List image;
  final int price;
  final int index;
  bool isItemFavourite;

  PetFoodItem({
    Key? key,
    this.isItemFavourite = false,
    required this.index,
    required this.title,
    required this.image,
    required this.price,
  }) : super(key: key);

  @override
  State<PetFoodItem> createState() => _PetFoodItemState();
}

int selectedProductIndex = 0;

class _PetFoodItemState extends State<PetFoodItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectedProductIndex = widget.index;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PetFoodItemPage()));
      },
      child: Container(
        height: 190,
        width: 184,
        color: white,
        padding: EdgeInsets.only(left: 3, right: 20, bottom: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 128,
              width: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(widget.image[0]))),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$ ${widget.price}',
                      style: TextStyle(
                        color: blue,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      widget.isItemFavourite = !widget.isItemFavourite;
                    });
                    if (widget.isItemFavourite) {
                      await ReadData().addFavourites(widget.index);
                    } else {
                      await ReadData().removeFavourite(widget.index);
                    }
                  },
                  child: Icon(
                    widget.isItemFavourite
                        ? Icons.favorite
                        : Icons.favorite_outline_rounded,
                    color: widget.isItemFavourite ? green : grey,
                    size: 26,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
