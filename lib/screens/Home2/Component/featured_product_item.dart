import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../Feature Product/feature_product.dart';

class FeaturedProductItem extends StatelessWidget {
  final int index;
  final String name;
  final String imageLocation;
  const FeaturedProductItem({
    Key? key,
    required this.name,
    required this.imageLocation,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectedFeaturedProdIndex = index;
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => FeaturedProductPage())));
      },
      child: Container(
        height: 209,
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
                    fit: BoxFit.cover,
                    image: AssetImage(imageLocation),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
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
          ],
        ),
      ),
    );
  }
}
