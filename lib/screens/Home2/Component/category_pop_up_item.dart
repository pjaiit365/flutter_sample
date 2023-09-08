import 'package:flutter/material.dart';

import '../../../constants.dart';

class CategoryPopUpItem extends StatelessWidget {
  final String categoryName;
   final String imageLocation;
  const CategoryPopUpItem({
    Key? key,
     required this.categoryName,
   required this.imageLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: 140,
      decoration: BoxDecoration(
          color: white,
          border: Border.all(color: grey, width: 1),
          borderRadius: BorderRadius.circular(9),
        
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.12),
              blurRadius: 2,
              spreadRadius: 2,
              offset: Offset(1, 3),
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Container(
            height: 90,
            width: 100,
            decoration: BoxDecoration(
              color: green,
              image: DecorationImage(
                  image: AssetImage(
                    imageLocation,
                  ),
                  fit: BoxFit.cover),
            ),
          
            
          ),
          SizedBox(height: 30),
          Text(
            categoryName,
            style: TextStyle(
              color: black,
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
