// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_life_gh/Services/read_data.dart';
import 'package:pet_life_gh/screens/Dashboard/dashboard_screen.dart';
import 'package:pet_life_gh/screens/wrapper.dart';

import '../../../constants.dart';
import '../../Dashboard/Components/pet_food_item.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

int addToCartNumber = 0;

class _BodyState extends State<Body> {
  int carouselItemIndex = 0;

  Future addToCart() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Cart')
          .where('User ID', isEqualTo: loggedInUserId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List prodIDs = querySnapshot.docs.single.get('Product IDs');
        List cart = querySnapshot.docs.single.get('Cart');

        if (prodIDs.contains(allProducts[selectedProductIndex].productID)) {
          throw Exception(
              '${allProducts[selectedProductIndex].title} has already been added to cart.');
        } else {
          prodIDs.add(allProducts[selectedProductIndex].productID);
          Map<String, dynamic> item = ({
            'Product ID': allProducts[selectedProductIndex].productID,
            'Title': allProducts[selectedProductIndex].title,
            'Number of Items': addToCartNumber,
            'Image': allProducts[selectedProductIndex].image[0],
            'Price': allProducts[selectedProductIndex].price,
            'Size': allProducts[selectedProductIndex].size,
          });
          cart.add(item);
        }

        await FirebaseFirestore.instance
            .collection('Cart')
            .doc(loggedInUserId)
            .update({
          'Cart': cart,
          'Product IDs': prodIDs,
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              content: Center(
                child: Text(
                    '${allProducts[selectedProductIndex].title} added to cart.'),
              ),
            ),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen(),
            ),
          );
        });
      } else {
        await FirebaseFirestore.instance
            .collection('Cart')
            .doc(loggedInUserId)
            .set({
          'User ID': loggedInUserId,
          'Cart': [
            {
              'Product ID': allProducts[selectedProductIndex].productID,
              'Title': allProducts[selectedProductIndex].title,
              'Number of Items': addToCartNumber,
              'Image': allProducts[selectedProductIndex].image[0],
              'Price': allProducts[selectedProductIndex].price,
              'Size': allProducts[selectedProductIndex].size,
            }
          ],
          'Product IDs': [allProducts[selectedProductIndex].productID]
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              content: Center(
                child: Text(
                    '${allProducts[selectedProductIndex].title} added to cart.'),
              ),
            ),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen(),
            ),
          );
        });
      }
    } on FirebaseException catch (error) {
      print(error.toString());
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Center(
            child: Text(
              e.toString(),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CarouselSlider.builder(
                          itemCount:
                              allProducts[selectedProductIndex].image.length,
                          itemBuilder: (context, index, realIndex) {
                            return Container(
                              height: 500,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: grey,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        allProducts[selectedProductIndex]
                                            .image[index],
                                      ),
                                      fit: BoxFit.cover)),
                            );
                          },
                          options: CarouselOptions(
                            height: 500,
                            autoPlay: false,
                            enlargeCenterPage: false,
                            onPageChanged: (index, reason) {
                              setState(() {
                                carouselItemIndex = index;
                                print(carouselItemIndex);
                              });
                            },
                          )),
                      Positioned(
                        bottom: 25,
                        left: 195,
                        child: SizedBox(
                          height: 7,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: ((context, index) {
                              return Container(
                                height: 7,
                                width: 7,
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                  color: (index == carouselItemIndex)
                                      ? green
                                      : white,
                                  shape: BoxShape.circle,
                                ),
                              );
                            }),
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 8);
                            },
                            itemCount:
                                allProducts[selectedProductIndex].image.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          allProducts[selectedProductIndex].details,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "\$ ${allProducts[selectedProductIndex].price}",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 5,
                    width: double.infinity,
                    color: grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Size",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${allProducts[selectedProductIndex].size} kg',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 2,
                          width: double.infinity,
                          color: grey.withOpacity(0.6),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  ProductPrice(
                    increaseQuantity: () {
                      setState(() {
                        addToCartNumber++;
                      });
                    },
                    reduceQuantity: () {
                      if (addToCartNumber > 0) {
                        setState(() {
                          addToCartNumber--;
                        });
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
        GestureDetector(
          onTap: addToCartNumber == 0
              ? () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      content: Center(
                        child: Text(
                            'Increase the quantity to add an item to cart.'),
                      ),
                    ),
                  );
                }
              : addToCart,
          child: Container(
            height: 70,
            width: double.infinity,
            color: white,
            alignment: Alignment.center,
            child: Container(
              height: 40,
              width: 150,
              color: blue,
              child: Center(
                child: Text(
                  "Add to cart",
                  style: TextStyle(
                    color: white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProductPrice extends StatefulWidget {
  final VoidCallback reduceQuantity;
  final VoidCallback increaseQuantity;
  const ProductPrice({
    super.key,
    required this.reduceQuantity,
    required this.increaseQuantity,
  });

  @override
  State<ProductPrice> createState() => _ProductPriceState();
}

class _ProductPriceState extends State<ProductPrice> {
  bool isDescriptionShowing = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Quantity",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                width: 150,
              ),
              InkWell(
                onTap: widget.reduceQuantity,
                splashColor: grey.withOpacity(0.3),
                child: Ink(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: grey,
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.remove),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                height: 30,
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: grey,
                  ),
                ),
                child: Center(child: Text(addToCartNumber.toString())),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: widget.increaseQuantity,
                splashColor: grey.withOpacity(0.3),
                child: Ink(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: grey,
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            constraints: BoxConstraints(minWidth: 40),
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isDescriptionShowing = !isDescriptionShowing;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_drop_down,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                isDescriptionShowing
                    ? ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 7,
                                width: 7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: black,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                allProducts[selectedProductIndex]
                                    .description[index],
                                style: TextStyle(height: 1.5),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 15);
                        },
                        itemCount: allProducts[selectedProductIndex]
                            .description
                            .length,
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
