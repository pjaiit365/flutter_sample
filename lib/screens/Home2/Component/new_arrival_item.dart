import 'package:flutter/material.dart';
import 'package:pet_life_gh/screens/New%20Arrival/new_arrival.dart';

import '../../../constants.dart';

class NewArrivalItem extends StatelessWidget {
  final int index;
  final String name;
  final String imageLocation;
  final String price;
  final String gender;
  const NewArrivalItem({
    Key? key,
    required this.name,
    required this.imageLocation,
    required this.price,
    required this.gender,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectedFeaturedProdIndex = index;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => NewArrivalPage()),
          ),
        );
      },
      child: Container(
        height: 300,
        width: 180,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            width: 1,
            color: grey,
          ),
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(
                0.12,
              ),
              blurRadius: 2,
              spreadRadius: 2,
              offset: Offset(1, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: 120,
                height: 130,
                decoration: BoxDecoration(
                  color: green,
                  borderRadius: BorderRadius.circular(9),
                  image: DecorationImage(
                      image: NetworkImage(imageLocation), fit: BoxFit.cover),
                ),
                child: imageLocation == ''
                    ? Center(child: Icon(Icons.pets_rounded, color: grey))
                    : SizedBox(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 35,
              ),
              child: Text(
                name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 35,
              ),
              child: Text(
                gender,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 35,
              ),
              child: Text(
                'GHS $price',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
