// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pet_life_gh/screens/Dashboard/Components/pet_food_item.dart';

import '../../../Services/read_data.dart';
import '../../../constants.dart';
import '../../Pet Food Item/pet_food_item_page.dart';

class PetClothingItem extends StatefulWidget {
  final int index;
  final String title;
  final String image;
  final int price;
  bool isItemFavourite = false;
  PetClothingItem({
    Key? key,
    this.isItemFavourite = false,
    required this.title,
    required this.image,
    required this.price,
    required this.index,
  }) : super(key: key);

  @override
  State<PetClothingItem> createState() => _PetClothingItemState();
}

class _PetClothingItemState extends State<PetClothingItem> {
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
        width: 180,
        color: white,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 20,
            left: 3,
            bottom: 6,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "asset/images/pet_clothing.png",
                height: 109,
                width: 163,
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
                        "\$ ${widget.price}",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: grey,
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
                          : Icons.favorite_border_outlined,
                      color: widget.isItemFavourite ? green : grey,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
