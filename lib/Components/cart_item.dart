// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../constants.dart';

class CartItem extends StatefulWidget {
  final String image;
  final int price;
  final double size;
  final int quantity;
  final String title;
  const CartItem({
    Key? key,
    required this.image,
    required this.price,
    required this.size,
    required this.quantity,
    required this.title,
  }) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int itemNumber = 0;

  @override
  void initState() {
    itemNumber = widget.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      child: Container(
        height: 140,
        width: 350,
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              width: 152,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(9),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.image),
                  )),
            ),
            SizedBox(
              width: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.title,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    '${widget.size} kg',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: grey,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "\$ ${widget.price}",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: black,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        itemNumber++;
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      color: grey,
                    ),
                  ),
                  Text(
                    '$itemNumber',
                    style: TextStyle(
                      color: blue,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      itemNumber > 0
                          ? setState(() {
                              itemNumber--;
                            })
                          : null;
                    },
                    icon: Icon(
                      Icons.remove,
                      color: grey,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
